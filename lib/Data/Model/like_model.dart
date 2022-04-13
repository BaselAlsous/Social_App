class LikeModel {
  String? like;
  String? uid;

  LikeModel({
    this.like,
    this.uid,
  });

  LikeModel.fromJson(Map<String, dynamic> json) {
    like = json['like'];
    uid = json['uid'];
  }

  Map<String, dynamic> toMap() {
    return {
      'like': like,
      'uid': uid,
    };
  }
}