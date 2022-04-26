import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Business/CallCubit/call_cubit.dart';
import 'package:social_app/Data/Model/call_model.dart';
import 'package:social_app/Presentaion/Screens/Chat/Screen/CallScreen/video_call_screen.dart';

class PickupScreen extends StatelessWidget {
  final Call? call;

  const PickupScreen({
    Key? key,
    this.call,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CallCubit(),
      child: BlocConsumer<CallCubit, CallState>(
        listener: (context, state) {},
        builder: (context, state) {
          CallCubit callCubit = CallCubit.get(context);
          return Scaffold(
            body: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Incoming...',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 50),
                  // CachedImage(
                  //   call.callerPic,
                  //   isRound: true,
                  //   radius: 180,
                  // ),
                  const SizedBox(height: 15),
                  Text(
                    call?.callerName ?? 'Error',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 75),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.call_end),
                        color: Colors.redAccent,
                        onPressed: () async {
                          await callCubit.endCall(call: call);
                        },
                      ),
                      const SizedBox(width: 25),
                      IconButton(
                        icon: const Icon(Icons.call),
                        color: Colors.green,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CallScreen(call: call),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
