class PostModel {
  String? name;
  String? uid;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;

  PostModel({
    this.name,
    this.uid,
    this.image,
    this.dateTime,
    this.postImage,
    this.text,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    name = json['name'];
    postImage = json['postImage'];
    uid = json['uid'];
    dateTime = json['dateTime'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dateTime': dateTime,
      'text': text,
      'uid': uid,
      'postImage': postImage,
      'image': image,
    };
  }
}
