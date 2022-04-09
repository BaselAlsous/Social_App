class ModelUserData {
  String? email;
  String? name;
  String? phone;
  String? uid;
  String? verifyEmail;
  String? image;
  String? cover;
  String? bio;

  ModelUserData({
    this.email,
    this.name,
    this.phone,
    this.uid,
    this.verifyEmail,
    this.image,
    this.cover,
    this.bio,
  });

  ModelUserData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uid = json['uid'];
    verifyEmail = json['verifyEmail'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'verifyEmail': verifyEmail,
      'image': image,
      'cover':cover,
      'bio': bio,
    };
  }
}
