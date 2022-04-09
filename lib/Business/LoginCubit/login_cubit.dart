// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_app/Data/Model/model_user_data.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get({context}) => BlocProvider.of(context);

  // todo: Function Toggle Show Password
  bool showPasswprd = true;

  void showPassword() {
    showPasswprd = !showPasswprd;
    emit(ToggleShowPasswordState());
  }

  // todo: Function To Regester Users

  void regesterUsers({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) async {
    emit(RegesterUsersLoadingState());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        createUsers(
          email: email,
          phone: phone,
          name: name,
          uid: value.user!.uid,
          image: 'https://img.freepik.com/free-photo/portrait-smiling-young-man-eyewear_171337-4842.jpg?t=st=1648848064~exp=1648848664~hmac=68c404c66a0de4d1e3fe168154109dd42ed918040aeb2ba06b12c57ec107fdf8&w=1060' ,
          cover: 'https://img.freepik.com/free-photo/background-image-pink-roses_39131-155.jpg?w=1060',
          bio: 'My bio ....',
        );
      }).catchError((error) {
        if (error.code == 'weak-password') {
          emit(RegesterUsersErrorState('The password provided is too weak.'));
        } else if (error.code == 'email-already-in-use') {
          emit(RegesterUsersErrorState(
              'The account already exists for that email.'));
        }
      });
    } catch (e) {
      print(e);
    }
  }

  // todo: Function Create Users

  void createUsers(
      {required String email,
      required String uid,
      required String phone,
      required String name,
      required String image,
      required String cover,
      required String bio,
      }) async {
    ModelUserData createUsersModel = ModelUserData(
      name: name,
      email: email,
      uid: uid,
      phone: phone,
      verifyEmail: 'false',
      image: image,
      cover: cover,
      bio: bio,
    );
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .set(createUsersModel.toMap())
        .then((value) {
      print('Will Create New User His Email Is :-' + email);
      print('His id is :- ' + uid);

      emit(CreateUsersSccessState(uid));
    }).catchError((error) {
      emit(CreateUsersErrorState(error.toString()));
    });
  }

  // todo: Function To Login Users

  void loginUsers({
    required String email,
    required String password,
  }) async {
    emit(LoginUsersLoadingState());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        print('Will Create New User' + value.user!.email.toString());
        print('His id is :- ' + value.user!.uid.toString());
        emit(LoginUsersSccessState(value.user!.uid));
      }).catchError((error) {
        if (error.code == 'user-not-found') {
          emit(LoginUsersErrorState('No user found for that email.'));
        } else if (error.code == 'wrong-password') {
          emit(LoginUsersErrorState('Wrong password provided for that user.'));
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
