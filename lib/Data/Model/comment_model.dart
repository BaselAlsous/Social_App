class CommentModel {
  String? name;
  String? image;
  String? text;
  String? postId;
  String? dateTime; 

  CommentModel({
    this.name,
    this.image,
    this.text,
    this.postId,
    this.dateTime,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    postId = json['postId'];
    text = json['text'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'text': text,
      'image': image,
      'name': name,
      'dateTime': dateTime,
    };
  }
}