class FollowerModel {
  String? name;
  String? uid;
  String? image;
  String? userUid;

  FollowerModel({
    this.name,
    this.uid,
    this.image,
    this.userUid,
  });

  FollowerModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    image = json['image'];
    userUid = json['userUid'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'image': image,
      'userUid':userUid,
    };
  }
}
