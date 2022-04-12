class FollowDoneModel {
  String? followDone;

  FollowDoneModel({
    this.followDone,
  });

  FollowDoneModel.fromJson(Map<String, dynamic> json) {
    followDone = json['followDone'];
  }

  Map<String, dynamic> toMap() {
    return {
      'followDone': followDone,
    };
  }
}