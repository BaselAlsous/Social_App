import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Business/AppCubit/app_cubit.dart';
import 'package:social_app/Business/CallCubit/call_cubit.dart';
import 'package:social_app/Data/Model/call_model.dart';

class CallScreen extends StatelessWidget {
  final Call? call;
  const CallScreen({Key? key, this.call}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CallCubit(),
      child: BlocConsumer<CallCubit, CallState>(
        listener: (context, state) {},
        builder: (context, state) {
          CallCubit callCubit = CallCubit.get(context);
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Call has been made'),
                  MaterialButton(
                      color: Colors.red,
                      child: const Icon(
                        Icons.call_end,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        callCubit.endCall(call: call);
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
