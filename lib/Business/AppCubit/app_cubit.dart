// ignore_for_file: avoid_print, avoid_single_cascade_in_expression_statements, avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Data/Constant/AppData/app_data.dart';
import 'package:social_app/Data/Constant/Method/navigation.dart';
import 'package:social_app/Data/Model/chat_model.dart';
import 'package:social_app/Data/Model/comment_model.dart';
import 'package:social_app/Data/Model/follow_done_model.dart';
import 'package:social_app/Data/Model/follower_model.dart';
import 'package:social_app/Data/Model/like_model.dart';
import 'package:social_app/Data/Model/model_post.dart';
import 'package:social_app/Data/Model/model_user_data.dart';
import 'package:social_app/Presentaion/Screens/Chat/Screen/chat_room_screen.dart';
import 'package:social_app/Presentaion/Screens/Home/Screens/home_screen.dart';
import 'package:social_app/Presentaion/Screens/Post/Screen/post_screen.dart';
import 'package:social_app/Presentaion/Screens/Profile/Screen/profile_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app/Presentaion/Screens/Users/Screens/users_screen.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  // todo: Function Toggle Bottom Nav Bar
  int defaultIndex = 0;
  List<Widget> title = [
    const Text('Home'),
    const Text('Chat'),
    const Text('Add Post'),
    const Text('Add Following'),
    const Text('Profile'),
  ];
  List<Widget> pages = [
    const HomeScreen(),
    const ChatRoomScreen(),
    const PostScreen(),
    const UsersScreen(),
    const ProfileScreen(),
  ];
  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.message), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.group_add), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
  ];

  void toggleNavBar(int index, BuildContext context) {
    if (index == 4) {
      getFollow();
    }
    if (index == 2) {
      Navigation.navigationAndBack(context: context, page: const PostScreen());
    } else {
      defaultIndex = index;
      emit(ToggleBottomNavBarState());
    }
  }

  // todo: Function To Get All Data Users

  ModelUserData? userData;

  void getUserData() {
    emit(GetUsersDataLoadingState());
    FirebaseFirestore.instance
        .collection('Users')
        .doc(AppData.uid)
        .get()
        .then((value) {
      userData = ModelUserData.fromJson(value.data() ?? {});
      emit(GetUsersDataSccessState());
    }).catchError((error) {
      emit(GetUsersDataErrorState(error.toString()));
    });
  }

  // todo: Verify Email Check

  void verifyEmail() {
    FirebaseFirestore.instance.collection('Users').doc(AppData.uid).update({
      'verifyEmail': 'ture',
    }).then((value) {
      emit(UpdatVerifyEmailSccessState());
    }).catchError((error) {
      emit(UpdatVerifyEmailErrorState(error));
    });
  }

  // todo: Upload Cover Image To Firebase FireStorge
  ImagePicker picker = ImagePicker();
  File? imageCover;

  Future<void> getCoverImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      imageCover = File(pickerFile.path);
      print("My Image Cover Is :-  " + imageCover.toString());
      emit(UpdatImageProfileCoverPickerSccessState());
    } else {
      emit(UpdatImageProfileCoverPickerErrorState(
          'Error :- In Image Picke Profile Cover'));
    }
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          "Users/${Uri.file(imageCover!.path).pathSegments.last}",
        )
        .putFile(imageCover!)
        .whenComplete(() => print('done'))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateData(
          coverImage: value,
        );
        emit(UpdatImageCoverSccessState());
      }).catchError((onError) {
        emit(UpdatImageCoverErrorState());
      });
    }).catchError((error) {
      emit(UpdatImageCoverErrorState());
    });
  }

  // todo: Upload Profile Image To Firebase FireStorge

  File? imageProfile;

  Future<void> getProfileImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      imageProfile = File(pickerFile.path);
      print('My Image Profile Is :- ' + imageProfile.toString());
      emit(UpdatImageProfileCoverPickerSccessState());
    } else {
      emit(UpdatImageProfileCoverPickerErrorState(
          'Error :- In Image Picke Profile'));
    }
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          "Users/${Uri.file(imageProfile!.path).pathSegments.last}",
        )
        .putFile(imageProfile!)
        .whenComplete(() => print('done'))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateData(
          profileImage: value,
        );
        emit(UpdatImageProfileSccessState());
      }).catchError((onError) {
        emit(UpdatImageProfileErrorState());
      });
    }).catchError((error) {
      emit(UpdatImageProfileErrorState());
    });
  }

  // todo: Function to Update Data

  void updateData({
    String? name,
    String? bio,
    String? phone,
    String? email,
    String? coverImage,
    String? profileImage,
    String? uid,
  }) {
    emit(UpdatUserDataLoadingState());
    ModelUserData updateUsersModel = ModelUserData(
      name: name ?? userData?.name,
      email: userData?.email,
      uid: userData?.uid,
      phone: phone ?? userData?.phone,
      verifyEmail: userData?.verifyEmail,
      image: profileImage ?? userData?.image,
      cover: coverImage ?? userData?.cover,
      bio: bio ?? userData?.bio,
    );

    FirebaseFirestore.instance
        .collection('Users')
        .doc(AppData.uid)
        .update(updateUsersModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UpdatUserDataErrorState());
    });
  }

  // todo: Function To Create Post

  File? imagePost;

  Future<void> getPostImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      imagePost = File(pickerFile.path);
      print("My Image Cover Is :-  " + imagePost.toString());
      emit(UpdatImagePostPickerSccessState());
    } else {
      emit(UpdatImagePostPickerErrorState('Error :- In Image Picke Post'));
    }
  }

  Future<void> uploadPostImage({
    required String date,
    required String text,
  }) async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
            "Users/${Uri.file(imagePost!.path).pathSegments.last}",
          )
          .putFile(imagePost!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          print(value);
          createNewPost(date: date, text: text, postImage: value);
          emit(UpdatImagePostSccessState());
        }).catchError((onError) {
          emit(UpdatImagePostErrorState());
        });
      }).catchError((error) {
        emit(UpdatImagePostErrorState());
      });
    } catch (e) {
      print(e);
    }
  }

  void deleteImagePost() {
    imagePost = null;
    emit(DeleteImagePostSccessState());
  }

  void createNewPost({
    required String date,
    required String text,
    String? postImage,
  }) {
    emit(CreateNewPostLoadingState());

    PostModel postModel = PostModel(
      name: userData?.name,
      uid: userData?.uid,
      image: userData?.image,
      dateTime: date,
      text: text,
      postImage: postImage ?? 'null',
    );

    FirebaseFirestore.instance
        .collection('Post')
        .add(postModel.toMap())
        .then((value) {
      print('Create New Post is Done.');
      emit(CreateNewPostSccessState());
    }).catchError((error) {
      print(error);
      emit(CreateNewPostErrorState());
    });
  }

  // todo: Function To Get All Posts
  List<PostModel> posts = [];
  List<String> postsId = [];

  void getAllPost() {
    emit(GetPostLoadingState());

    FirebaseFirestore.instance
        .collection('Post')
        .orderBy('dateTime', descending: true)
        .get()
        .then((value) {
      posts = [];
      value.docs.forEach((element) {
        postsId.add(element.id);
        posts.add(PostModel.fromJson(element.data()));
      });
      emit(GetPostSccessState());
    }).catchError((error) {
      emit(GetPostErrorState(error));
    });
  }

  // todo: Function To Get User Posts
  List<PostModel> userPost = [];

  void getpostUser() {
    FirebaseFirestore.instance
        .collection('Post')
        .where('uid', isEqualTo: AppData.uid)
        .snapshots()
        .listen((event) {
      userPost = [];
      event.docs.forEach((element) {
        userPost.add(PostModel.fromJson(element.data()));
      });
      emit(GetUserPostSccessState());
    });
  }

  // todo: Like Press

  void sendLikePress({
    required String? postId,
  }) {
    LikeModel likeModel = LikeModel(
      like: 'true',
      uid: AppData.uid,
    );

    FirebaseFirestore.instance
        .collection('Post Likes')
        .doc(AppData.uid)
        .collection('Like')
        .doc(postId)
        .set(likeModel.toMap())
        .then((value) {
      emit(LikePostSccessState());
    }).catchError((error) {
      emit(LikePostErrorState());
    });

    // FirebaseFirestore.instance
    //     .collection('Users')
    //     .doc(AppData.uid)
    //     .collection('Likes')
    //     .doc(postId)
    //     .set(likeModel.toMap())
    //     .then((value) {
    //   emit(LikePostSccessState());
    // }).catchError((error) {
    //   emit(LikePostErrorState());
    // });
  }

  List<LikeModel> allLike = [];

  void getLikePress() {
    FirebaseFirestore.instance
        .collection('Post Likes')
        .doc(AppData.uid)
        .collection('Like')
        .where('uid', isEqualTo: AppData.uid)
        .snapshots()
        .listen((event) {
      allLike = [];
      event.docs.forEach((element) {
        allLike.add(LikeModel.fromJson(element.data()));
      });
    });
    print(allLike.length.toString());
    emit(GetLikePostSccessState());
  }

  // List<LikeModel> myLike = [];

  // void getMyLike() {
  //   FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(AppData.uid)
  //       .collection('Likes')
  //       .snapshots()
  //       .listen((event) {
  //     myLike = [];
  //     event.docs.forEach((element) {
  //       myLike.add(LikeModel.fromJson(element.data()));
  //     });
  //   });
  //   print(myLike.length.toString() + '  sdfghjkl;lkjhgfdghjkl;kjhgf');
  // }

  // todo: Get All User

  List<ModelUserData> allUser = [];

  void getAllUser() {
    emit(GetAllUserLoadingState());
    FirebaseFirestore.instance.collection('Users').snapshots().listen((event) {
      allUser = [];
      event.docs.forEach((element) {
        if (element.data()['uid'] != AppData.uid) {
          allUser.add(ModelUserData.fromJson(element.data()));
        }
      });
    });
    emit(GetAllUserSccessState());
  }

  // todo: Function Chat

  List<ModelUserData> allChatUser = [];

  void getAllChatUser() {
    try {
      FirebaseFirestore.instance
          .collection('Chat Room')
          .doc(AppData.uid)
          .collection('Chat')
          .snapshots()
          .listen((event) {
        allChatUser = [];
        event.docs.forEach((element) {
          allChatUser.add(ModelUserData.fromJson(element.data()));
        });
        emit(GetUsersChatSccessState());
      });
    } catch (e) {
      print(e);
    }
  }

  void sendMessamge({
    String? date,
    String? reseveUid,
    String? text,
    String? chatImage,
    String? imageReseve,
    String? nameReseve,
    String? bioReseve,
    String? uidReseve,
    String? emailReseve,
    String? imageSend,
    String? nameSend,
    String? bioSend,
    String? uidSend,
    String? emailSend,
  }) {
    ModelUserData userChatSend = ModelUserData(
      image: imageSend,
      name: nameSend,
      bio: bioSend,
      uid: uidSend,
      email: emailSend,
    );

    ModelUserData userChatReseve = ModelUserData(
      image: imageReseve,
      name: nameReseve,
      bio: bioReseve,
      uid: uidReseve,
      email: emailReseve,
    );

    ChatModel chatModel = ChatModel(
      text: text,
      date: date,
      reseveUid: reseveUid,
      sendUid: AppData.uid,
      chatImage: chatImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('Chat Room')
        .doc(AppData.uid)
        .collection('Chat')
        .doc(reseveUid)
        .collection('messagae')
        .add(chatModel.toMap())
        .then((value) {
      emit(SendMessageSccessState());
    }).catchError((error) {
      emit(SendMessageErrorState(error));
    });

    FirebaseFirestore.instance
        .collection('Chat Room')
        .doc(AppData.uid)
        .collection('Chat')
        .doc(reseveUid)
        .set(userChatReseve.toMap())
        .then((value) {
      emit(SendMessageSccessState());
    }).catchError((error) {
      emit(SendMessageErrorState(error));
    });

    FirebaseFirestore.instance
        .collection('Chat Room')
        .doc(reseveUid)
        .collection('Chat')
        .doc(AppData.uid)
        .collection('messagae')
        .add(chatModel.toMap())
        .then((value) {
      emit(SendMessageSccessState());
    }).catchError((error) {
      emit(SendMessageErrorState(error));
    });

    FirebaseFirestore.instance
        .collection('Chat Room')
        .doc(reseveUid)
        .collection('Chat')
        .doc(AppData.uid)
        .set(userChatSend.toMap())
        .then((value) {
      emit(SendMessageSccessState());
    }).catchError((error) {
      emit(SendMessageErrorState(error));
    });
  }

  List<ChatModel> chat = [];

  void getmessage({
    String? reseveUid,
  }) {
    FirebaseFirestore.instance
        .collection('Chat Room')
        .doc(AppData.uid)
        .collection('Chat')
        .doc(reseveUid)
        .collection('messagae')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      chat = [];
      event.docs.reversed.forEach((element) {
        chat.add(ChatModel.fromJson(element.data()));
      });
      emit(GetMessageSccessState());
    });
  }

  void deleteChat({
    required String reseveUid,
  }) {
    FirebaseFirestore.instance
        .collection('Chat Room')
        .doc(AppData.uid)
        .collection('Chat')
        .doc(reseveUid)
        .collection('messagae')
        .get()
        .then((value) {
      for (DocumentSnapshot i in value.docs) {
        i.reference.delete();
      }
      emit(DeleteChatSccessState());
    }).catchError((error) {
      emit(DeleteChatErrorState(error));
    });
    FirebaseFirestore.instance
        .collection('Chat Room')
        .doc(AppData.uid)
        .collection('Chat')
        .get()
        .then((value) {
      for (DocumentSnapshot i in value.docs) {
        i.reference.delete();
      }
      emit(DeleteChatSccessState());
    }).catchError((error) {
      emit(DeleteChatErrorState(error));
    });
  }

  File? chatImage;

  Future<void> getChatImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      chatImage = File(pickerFile.path);
      print("My Image Cover Is :-  " + chatImage.toString());
      emit(GetChatImagePickerSccessState());
    } else {
      emit(GetChatImagePickerErrorState('Error :- In Image Picker Chat'));
    }
  }

  Future<void> uploadChatImage({
    required String? date,
    required String? text,
    required String? reseveUid,
    String? imageReseve,
    String? nameReseve,
    String? bioReseve,
    String? uidReseve,
    String? emailReseve,
    String? imageSend,
    String? nameSend,
    String? bioSend,
    String? uidSend,
    String? emailSend,
  }) async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
            "Chat/${Uri.file(chatImage!.path).pathSegments.last}",
          )
          .putFile(chatImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          print(value);
          sendMessamge(
            chatImage: value,
            text: text,
            date: date,
            reseveUid: reseveUid,
            imageReseve: imageReseve,
            nameReseve: nameReseve,
            bioReseve: bioReseve,
            uidReseve: uidReseve,
            emailReseve: emailReseve,
            imageSend: imageSend,
            nameSend: nameSend,
            bioSend: bioSend,
            uidSend: uidSend,
            emailSend: emailSend,
          );
          emit(SendChatImageSccessState());
        }).catchError((error) {
          emit(SendChatImageErrorState(error.toString()));
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void deleteChatImage() {
    chatImage = null;
    emit(DeleteChatImageSccessState());
  }

  // todo: Function To Follow Users

  FollowerModel? followerModel;
  FollowerModel? followingModel;

  void followUser({
    String? name,
    String? uid,
    String? image,
    String? myName,
    String? myUid,
    String? myImage,
    String? userUid,
  }) {
    followingModel = FollowerModel(
      name: name,
      image: image,
      uid: uid,
      userUid: userUid,
    );
    followerModel = FollowerModel(
      name: myName,
      image: myImage,
      uid: myUid,
      userUid: AppData.uid,
    );

    FirebaseFirestore.instance
        .collection('Users')
        .doc(AppData.uid)
        .collection('Following')
        .doc(userUid)
        .set(followingModel!.toMap())
        .then((value) {
      emit(SendFollowerSccessState());
    }).catchError((error) {
      emit(SendFollowerErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(userUid)
        .collection('Followers')
        .doc(AppData.uid)
        .set(followerModel!.toMap())
        .then((value) {
      emit(SendFollowerSccessState());
    }).catchError((error) {
      emit(SendFollowerErrorState(error.toString()));
    });
  }

  List<FollowerModel> follower = [];
  List<FollowerModel> following = [];

  void getFollow() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(AppData.uid)
        .collection('Followers')
        .get()
        .then((value) {
      follower = [];
      value.docs.forEach((element) {
        follower.add(FollowerModel.fromJson(element.data()));
      });
      emit(GetFollowerSccessState());
    }).catchError((error) {
      emit(GetFollowerErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(AppData.uid)
        .collection('Following')
        .get()
        .then((value) {
      following = [];
      value.docs.forEach((element) {
        following.add(FollowerModel.fromJson(element.data()));
      });
      emit(GetFollowerSccessState());
    }).catchError((error) {
      emit(GetFollowerErrorState(error.toString()));
    });
  }

  // todo: Get All Follower And Following Users

  List<FollowerModel> followerUsers = [];
  List<FollowerModel> followingUsers = [];

  void getFollowUsers({
    required String userUid,
  }) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userUid)
        .collection('Followers')
        .get()
        .then((value) {
      followerUsers = [];
      value.docs.forEach((element) {
        followerUsers.add(FollowerModel.fromJson(element.data()));
      });
      emit(GetFollowerUsersSccessState());
    }).catchError((error) {
      emit(GetFollowerUsersErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(userUid)
        .collection('Following')
        .get()
        .then((value) {
      followingUsers = [];
      value.docs.forEach((element) {
        followingUsers.add(FollowerModel.fromJson(element.data()));
      });
      emit(GetFollowDoneUsersSccessState());
    }).catchError((error) {
      emit(GetFollowDoneUsersErrorState(error.toString()));
    });
  }

  List<FollowDoneModel> followDoneModel = [];

  void followDone() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(AppData.uid)
        .collection('Following')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        followDoneModel.add(FollowDoneModel.fromJson(element.data()));
      });
      emit(GetFollowDoneSccessState());
    }).catchError((error) {
      emit(GetFollowDoneErrorState(error.toString()));
    });
  }

  void unFollow({
    String? userUid,
  }) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(AppData.uid)
        .collection('Following')
        .doc(userUid)
        .delete();
    emit(DeleteFollowSccessState());

    FirebaseFirestore.instance
        .collection('Users')
        .doc(userUid)
        .collection('Followers')
        .doc(AppData.uid)
        .delete();
    emit(DeleteFollowSccessState());
  }

  // todo: Function Commenet Posts

  void commentPost(
    String? name,
    String? image,
    String? text,
    String? idPost,
    String? dateTime,
  ) {
    CommentModel commentModel = CommentModel(
      name: name,
      image: image,
      postId: idPost,
      text: text,
      dateTime: dateTime,
    );

    FirebaseFirestore.instance
        .collection('Post Comments')
        .doc(idPost)
        .collection('Comments')
        .add(commentModel.toMap())
        .then((value) {
      emit(SendCommentSccessState());
    }).catchError((error) {
      emit(SendCommentErrorState(error));
    });
  }

  List<CommentModel> allComment = [];

  void getAllComment({
    String? idPost,
  }) {
    FirebaseFirestore.instance
        .collection('Post Comments')
        .doc(idPost)
        .collection('Comments')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      allComment = [];
      event.docs.forEach((element) {
        allComment.add(CommentModel.fromJson(element.data()));
      });
      emit(GetCommentSccessState());
    });
  }

  // todo: Get Post Users
  List<PostModel> usersPost = [];
  void getUsersPosts({
    required String userUid,
  }) {
    emit(GetUsersPostsLoadingState());

    FirebaseFirestore.instance
        .collection('Post')
        .where('uid', isEqualTo: userUid)
        .get()
        .then((value) {
      usersPost = [];
      value.docs.forEach((element) {
        usersPost.add(PostModel.fromJson(element.data()));
      });
      emit(GetUsersPostsSccessState());
    }).catchError((error) {
      emit(GetUsersPostsErrorState(error));
    });
  }
}
