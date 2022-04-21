import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/Business/AppCubit/app_cubit.dart';
import 'package:social_app/Data/Constant/Method/navigation.dart';
import 'package:social_app/Data/Model/follower_model.dart';
import 'package:social_app/Data/Model/model_post.dart';
import 'package:social_app/Data/Model/model_user_data.dart';
import 'package:social_app/Presentaion/Screens/Chat/Screen/chat_screen.dart';
import 'package:social_app/Presentaion/Screens/Home/Components/custom_post_item.dart';

class UsersProfileScreen extends StatefulWidget {
  final ModelUserData modelUserData;
  final int index;
  const UsersProfileScreen(
      {Key? key, required this.modelUserData, required this.index})
      : super(key: key);

  @override
  State<UsersProfileScreen> createState() => _UsersProfileScreenState();
}

class _UsersProfileScreenState extends State<UsersProfileScreen> {
  bool imagePost = true;
  bool commentPost = false;
  Color imgActiveBkButton = Colors.blueAccent;
  Color imgActiveTxButton = Colors.white;
  Color comActiveBkButton = Colors.white;
  Color comActiveTxButton = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getUsersPosts(userUid: widget.modelUserData.uid!)
        ..getFollowUsers(userUid: widget.modelUserData.uid!)
        ..getUserData()
        ..getAllPost(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit appCubit = AppCubit.get(context);
          List<PostModel> postUsers = AppCubit.get(context).usersPost;
          List<FollowerModel> followerUsers =
              AppCubit.get(context).followerUsers;
          List<FollowerModel> followingUsers =
              AppCubit.get(context).followingUsers;

          return Scaffold(
            appBar: AppBar(),
            body: RefreshIndicator(
              onRefresh: () async {
                appCubit.getUsersPosts(userUid: widget.modelUserData.uid!);
                appCubit.getFollowUsers(userUid: widget.modelUserData.uid!);
                appCubit.getUserData();
                appCubit.getAllPost();
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.0.h,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: double.infinity,
                              height: 20.0.h,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                              ),
                              child: Image(
                                image: NetworkImage(
                                    '${widget.modelUserData.cover}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 65.0,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage:
                                  NetworkImage('${widget.modelUserData.image}'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    Text(
                      '${widget.modelUserData.name}',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    Text(
                      '${widget.modelUserData.bio}',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(fontSize: 15.0),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.0.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    'Following',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  SizedBox(
                                    height: 2.0.h,
                                  ),
                                  Text(followingUsers.length.toString()),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    'Post',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  SizedBox(
                                    height: 2.0.h,
                                  ),
                                  Text(postUsers.length.toString()),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    'Followers',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  SizedBox(
                                    height: 2.0.h,
                                  ),
                                  Text(followerUsers.length.toString()),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              'Follow',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1.0.w,
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigation.navigationAndBack(
                                context: context,
                                page: ChatScreen(
                                    modelUserData: widget.modelUserData),
                              );
                            },
                            child: Icon(
                              Icons.chat,
                              color: Colors.grey,
                              size: 14.0.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0.sp),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextButton(
                            child: Text('Post Image',
                                style: TextStyle(
                                  color: imgActiveTxButton,
                                )),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    imgActiveBkButton)),
                            onPressed: () {
                              setState(() {
                                imagePost = true;
                                commentPost = false;
                                imgActiveBkButton = Colors.blueAccent;
                                imgActiveTxButton = Colors.white;
                                comActiveBkButton =
                                    Theme.of(context).scaffoldBackgroundColor;
                                comActiveTxButton = Colors.grey;
                              });
                            },
                          )),
                          SizedBox(
                            width: 1.w,
                          ),
                          Expanded(
                              child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    comActiveBkButton)),
                            child: Text('Post Commint',
                                style: TextStyle(
                                  color: comActiveTxButton,
                                )),
                            onPressed: () {
                              setState(() {
                                commentPost = true;
                                imagePost = false;
                                comActiveBkButton = Colors.blueAccent;
                                comActiveTxButton = Colors.white;
                                imgActiveBkButton =
                                    Theme.of(context).scaffoldBackgroundColor;
                                imgActiveTxButton = Colors.grey;
                              });
                            },
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Container(
                        height: 1.0,
                        color: Colors.grey[300],
                      ),
                    ),
                    if (imagePost && postUsers.isNotEmpty)
                      MyImagePosts(
                        model: postUsers,
                      ),
                    if (commentPost && postUsers.isNotEmpty)
                      MyCommintPost(
                        appCubit: appCubit,
                        model: postUsers,
                      ),
                    if (postUsers.isEmpty)
                      SizedBox(
                        height: 20.0.h,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'You Dont Share Any Post',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    if (postUsers.length <= 3)
                      SizedBox(
                        height: 15.0.h,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyImagePosts extends StatelessWidget {
  final List<PostModel> model;
  const MyImagePosts({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.0.w),
      child: GridView.builder(
        padding: const EdgeInsets.only(top: 15.0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: model.length,
        itemBuilder: (context, index) {
          if (model[index].postImage != 'null') {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(model[index].postImage != 'null'
                        ? '${model[index].postImage}'
                        : 'Asset/Images/new_post.jpg'),
                    fit: BoxFit.cover,
                  )),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('Asset/Images/new_post.jpg'),
                    fit: BoxFit.cover,
                  )),
            );
          }
        },
      ),
    );
  }
}

class MyCommintPost extends StatelessWidget {
  final List<PostModel> model;
  final AppCubit appCubit;
  const MyCommintPost({Key? key, required this.model, required this.appCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.0.w),
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 15.0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: model.length,
        itemBuilder: (context, index) {
          return CustomePostItem(
            appCubit: appCubit,
            index: index,
            modelUserData: appCubit.userData!,
            postModel: model[index],
          );
        },
      ),
    );
  }
}
