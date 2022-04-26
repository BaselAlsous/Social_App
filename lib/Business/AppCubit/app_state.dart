part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

// todo: Classes Get User Data

class GetUsersDataLoadingState extends AppState {}

class GetUsersDataSccessState extends AppState {}

class GetUsersDataErrorState extends AppState {
  final String error;
  GetUsersDataErrorState(this.error);
}


// todo: Classes Get Users Post

class GetUsersPostsLoadingState extends AppState {}

class GetUsersPostsSccessState extends AppState {}

class GetUsersPostsErrorState extends AppState {
  final String error;
  GetUsersPostsErrorState(this.error);
}

// todo: Classes Get All Post

class GetPostLoadingState extends AppState {}

class GetPostSccessState extends AppState {}

class GetPostErrorState extends AppState {
  final String error;
  GetPostErrorState(this.error);
}

//todo : Classes Send Follower

class SendFollowerSccessState extends AppState {}

class SendFollowerErrorState extends AppState {
  final String error;
  SendFollowerErrorState(this.error);
}

//todo : Classes GET Follower

class GetFollowerSccessState extends AppState {}

class GetFollowerErrorState extends AppState {
  final String error;
  GetFollowerErrorState(this.error);
}

//todo : Classes GET Follower Users

class GetFollowerUsersSccessState extends AppState {}

class GetFollowerUsersErrorState extends AppState {
  final String error;
  GetFollowerUsersErrorState(this.error);
}


//todo : Classes GET Follower Users

class GetFollowDoneUsersSccessState extends AppState {}

class GetFollowDoneUsersErrorState extends AppState {
  final String error;
  GetFollowDoneUsersErrorState(this.error);
}

//todo : Classes GET Follower

class GetFollowDoneSccessState extends AppState {}

class GetFollowDoneErrorState extends AppState {
  final String error;
  GetFollowDoneErrorState(this.error);
}

//todo : Classes GET Follower

class SendCommentSccessState extends AppState {}

class SendCommentErrorState extends AppState {
  final String error;
  SendCommentErrorState(this.error);
}

//todo : Classes GET Follower

class GetCommentSccessState extends AppState {}

class GetCommentErrorState extends AppState {
  final String error;
  GetCommentErrorState(this.error);
}

//todo : Classes Delete Follow

class DeleteFollowSccessState extends AppState {}

// todo: Classes Get All User Post

class GetUserPostLoadingState extends AppState {}

class GetUserPostSccessState extends AppState {}

class GetUserPostErrorState extends AppState {
  final String error;
  GetUserPostErrorState(this.error);
}

// todo: Classes Get Users Chat

class GetUsersChatSccessState extends AppState {}

class GetUsersChatErrorState extends AppState {
  final String error;
  GetUsersChatErrorState(this.error);
}

// todo: Classes Send Message

class SendMessageSccessState extends AppState {}

class SendMessageErrorState extends AppState {
  final String error;
  SendMessageErrorState(this.error);
}

// todo: Class Get Message

class GetMessageSccessState extends AppState {}

// todo: Class Delete Chat

class DeleteChatSccessState extends AppState {}

class DeleteChatErrorState extends AppState {
  final String error;

  DeleteChatErrorState(this.error);
}

// todo: Classes Image Piker Chat

class GetChatImagePickerSccessState extends AppState {}

class GetChatImagePickerErrorState extends AppState {
  final String error;

  GetChatImagePickerErrorState(this.error);
}

// todo: Classes Send Image Chat

class SendChatImageSccessState extends AppState {}

class SendChatImageErrorState extends AppState {
  final String error;

  SendChatImageErrorState(this.error);
}

class DeleteChatImageSccessState extends AppState {}

// todo: Classes Like Post

class LikePostErrorState extends AppState {}

class LikePostSccessState extends AppState {}

// todo: Classes Like Post

class GetLikePostErrorState extends AppState {}

class GetLikePostSccessState extends AppState {}

// todo: Classes Get All User

class GetAllUserErrorState extends AppState {}

class GetAllUserSccessState extends AppState {}

class GetAllUserLoadingState extends AppState {}

// todo: Classes Toggle Bottom Nav Bar

class ToggleBottomNavBarState extends AppState {}

// todo: Classes Update Verify Email

class UpdatVerifyEmailSccessState extends AppState {}

class UpdatVerifyEmailErrorState extends AppState {
  final String error;
  UpdatVerifyEmailErrorState(this.error);
}

// todo: Classes To Select Image Used Image Picker

class UpdatImageProfileCoverPickerSccessState extends AppState {}

class UpdatImageProfileCoverPickerErrorState extends AppState {
  final String error;

  UpdatImageProfileCoverPickerErrorState(this.error);
}

class UpdatImageProfilePickerSccessState extends AppState {}

class UpdatImageProfilePickerErrorState extends AppState {
  final String error;

  UpdatImageProfilePickerErrorState(this.error);
}

class UpdatImagePostPickerSccessState extends AppState {}

class UpdatImagePostPickerErrorState extends AppState {
  final String error;

  UpdatImagePostPickerErrorState(this.error);
}

class UpdatImageProfileSccessState extends AppState {}

class UpdatImageProfileErrorState extends AppState {}

class UpdatImageCoverSccessState extends AppState {}

class UpdatImageCoverErrorState extends AppState {}

class UpdatImagePostSccessState extends AppState {}

class UpdatImagePostErrorState extends AppState {}

class UpdatUserDataLoadingState extends AppState {}

class UpdatUserDataSccessState extends AppState {}

class UpdatUserDataErrorState extends AppState {}

class DeleteImagePostSccessState extends AppState {}

class CreateNewPostLoadingState extends AppState {}

class CreateNewPostSccessState extends AppState {}

class CreateNewPostErrorState extends AppState {}

