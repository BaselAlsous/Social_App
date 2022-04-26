import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Data/Model/call_model.dart';
import 'package:social_app/Data/Model/model_user_data.dart';
import 'package:social_app/Presentaion/Screens/Chat/Screen/CallScreen/video_call_screen.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  CallCubit() : super(CallInitial());

  static CallCubit get(context) => BlocProvider.of(context);


// todo: Function To Make Calling

  static Future<bool> makeCall({Call? call}) async {
    try {
      call?.hasDialled = true;
      Map<String, dynamic> hasDialledMap = call!.toMap(call);

      call.hasDialled = false;
      Map<String, dynamic> hasNotDialledMap = call.toMap(call);

      await FirebaseFirestore.instance
          .collection('Call')
          .doc(call.callerId)
          .set(hasDialledMap);

      await FirebaseFirestore.instance
          .collection('Call')
          .doc(call.receiverId)
          .set(hasNotDialledMap);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

// todo: Function To End Calling

  Future<bool> endCall({Call? call}) async {
    try {
      await FirebaseFirestore.instance
          .collection('Call')
          .doc(call?.callerId)
          .delete()
          .then((value) {
        emit(EndCallSccess());
      }).catchError((error) {
        emit(EndCallError(error: error));
      });
      await FirebaseFirestore.instance
          .collection('Call')
          .doc(call?.receiverId)
          .delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

// todo: dial

  dial({ModelUserData? from, ModelUserData? to, context}) async {
    Call call = Call(
      callerId: from?.uid,
      callerName: from?.name,
      callerPic: from?.image,
      receiverId: to?.uid,
      receiverName: to?.name,
      receiverPic: to?.image,
      channelId: Random().nextInt(1000).toString(),
    );

    bool callMade = await makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallScreen(call: call),
          ));
    }
  }

// todo: callStream

  Call? call;

  void callStream({String? uid}){
    FirebaseFirestore.instance
    .collection('Call')
    .doc(uid)
    .snapshots()
    .listen((event) {
      call = Call.fromMap(event.data()!);
    });
  }

}
