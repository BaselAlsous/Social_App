class Call {
  String? callerId;
  String? callerName;
  String? callerPic;
  String? receiverId;
  String? receiverName;
  String? receiverPic;
  String? channelId;
  bool? hasDialled;

  Call({
    this.callerId,
    this.callerName,
    this.callerPic,
    this.receiverId,
    this.receiverName,
    this.receiverPic,
    this.channelId,
    this.hasDialled,
  });

  // to map

Map<String, dynamic> toMap(Call call) {
    return {
      'caller_id': callerId,
      'caller_name': callerName,
      'caller_pic': callerPic,
      'receiver_id': receiverId,
      'receiver_name': receiverName,
      'receiver_pic': receiverPic,
      'channel_id': channelId,
      'has_dialled': hasDialled,
    };
}

  Call.fromMap(Map callMap) {
    callerId = callMap['caller_id'];
    callerName = callMap['caller_name'];
    callerPic = callMap['caller_pic'];
    receiverId = callMap['receiver_id'];
    receiverName = callMap['receiver_name'];
    receiverPic = callMap['receiver_pic'];
    channelId = callMap['channel_id'];
    hasDialled = callMap['has_dialled'];
  }
}
