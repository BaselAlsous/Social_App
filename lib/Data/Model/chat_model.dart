class ChatModel {
  String? date;
  String? sendUid;
  String? reseveUid;
  String? text;
  String? chatImage;

  ChatModel({
    this.date,
    this.sendUid,
    this.reseveUid,
    this.text,
    this.chatImage,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    sendUid = json['sendUid'];
    reseveUid = json['reseveUid'];
    text = json['text'];
    chatImage = json['chatImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'sendUid': sendUid,
      'date': date,
      'text': text,
      'reseveUid': reseveUid,
      'chatImage': chatImage,
    };
  }
}
