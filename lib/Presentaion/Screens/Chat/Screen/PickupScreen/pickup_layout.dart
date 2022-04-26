import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:social_app/Business/AppCubit/app_cubit.dart';
import 'package:social_app/Business/CallCubit/call_cubit.dart';
import 'package:social_app/Data/Model/call_model.dart';
import 'package:social_app/Data/Model/model_user_data.dart';
import 'package:social_app/Presentaion/Screens/Chat/Screen/PickupScreen/pickup_screen.dart';

class PickupLayout extends StatelessWidget {
  final Widget scaffold;
  final ModelUserData modelUserData;

  // ignore: use_key_in_widget_constructors
  const PickupLayout({
    required this.scaffold,
    required this.modelUserData,
  });

  @override
  Widget build(BuildContext context) {
    return (modelUserData.uid!.isNotEmpty)
        ? Builder(builder: (context) {
            CallCubit.get(context).callStream(uid: modelUserData.uid);
            return BlocProvider(
              create: (context) => CallCubit(),
              child: BlocConsumer<CallCubit, CallState>(
                listener: (context, state) {},
                builder: (context, state) {
                  CallCubit callCubit = CallCubit.get(context);
                  Call? call = callCubit.call;
                  if (call!.callerId!.isNotEmpty) {
                    return PickupScreen(call: call);
                  }
                  return scaffold;
                },
              ),
            );
          })
        : const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
