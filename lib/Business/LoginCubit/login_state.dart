part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

// todo: Class Toggle Password State

class ToggleShowPasswordState extends LoginState {}

// todo: Classes Regester Users

class RegesterUsersLoadingState extends LoginState {}

class RegesterUsersSccessState extends LoginState {}

class RegesterUsersErrorState extends LoginState {
  final String error;
  RegesterUsersErrorState(this.error);
}

// todo: Classes Create Users

class CreateUsersLoadingState extends LoginState {}

class CreateUsersSccessState extends LoginState {
  final String uid;
  CreateUsersSccessState(this.uid);
}

class CreateUsersErrorState extends LoginState {
  final String error;
  CreateUsersErrorState(this.error);
}

// todo: Classes Login Users

class LoginUsersLoadingState extends LoginState {}

class LoginUsersSccessState extends LoginState {
  final String uid;
  LoginUsersSccessState(this.uid);
}

class LoginUsersErrorState extends LoginState {
  final String error;

  LoginUsersErrorState(this.error);
}
