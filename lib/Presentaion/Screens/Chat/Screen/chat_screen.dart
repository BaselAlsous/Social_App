// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/Business/AppCubit/app_cubit.dart';
import 'package:social_app/Business/CallCubit/call_cubit.dart';
import 'package:social_app/Data/Constant/AppData/app_data.dart';
import 'package:social_app/Data/Model/chat_model.dart';
import 'package:social_app/Data/Model/model_user_data.dart';
import 'package:social_app/Presentaion/Components/custom_appbar_chat.dart';

class ChatScreen extends StatelessWidget {
  final ModelUserData modelUserData;
  const ChatScreen({
    Key? key,
    required this.modelUserData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textTextEditingController = TextEditingController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..getUserData(),
        ),
        BlocProvider(
          create: (context) => CallCubit(),
        ),
      ],
      child: Builder(builder: (context) {
        AppCubit.get(context).getmessage(reseveUid: modelUserData.uid);
        return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var appCubit = AppCubit.get(context);
            var chat = appCubit.chat;
            CallCubit callCubit = CallCubit.get(context);
            return Scaffold(
              appBar: customeAppBarChat(
                context: context,
                title: modelUserData.name ?? 'Error',
                image: '${modelUserData.image}',
                action: [
                  IconButton(
                    onPressed: () {
                      callCubit.dial(
                        from: appCubit.userData,
                        to: modelUserData,
                        context: context,
                      );
                    },
                    icon: const Icon(
                      Icons.video_call,
                      color: Colors.grey,
                      size: 27.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.call,
                      color: Colors.grey,
                      size: 27.0,
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: EdgeInsets.all(15.0.sp),
                child: Column(
                  children: [
                    Expanded(
                      child: ConditionalBuilder(
                        condition: chat.isNotEmpty,
                        fallback: (context) => Column(
                          children: [
                            CircleAvatar(
                              radius: 55.0,
                              backgroundImage:
                                  NetworkImage('${modelUserData.image}'),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Text(
                                modelUserData.name ?? 'Error',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                            Text(
                              modelUserData.bio ?? 'Error',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(fontSize: 12.0.sp),
                            ),
                          ],
                        ),
                        builder: (context) => ListView.separated(
                          reverse: true,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: chat.length,
                          itemBuilder: (context, index) {
                            if (AppData.uid == chat[index].sendUid) {
                              return buildIsendTo(
                                  context: context, chatModel: chat[index]);
                            } else {
                              return buildHeSend(
                                  context: context, chatModel: chat[index]);
                            }
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 5.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (appCubit.chatImage != null)
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 20.0.h,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                            ),
                            child: Image(
                              image: FileImage(appCubit.chatImage!),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                appCubit.deleteChatImage();
                              },
                              child: const CircleAvatar(
                                radius: 15.0,
                                backgroundColor: Colors.blueAccent,
                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    Container(
                      width: double.infinity,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          MaterialButton(
                            padding: EdgeInsets.zero,
                            elevation: 0.0,
                            onPressed: () {
                              appCubit.getChatImage();
                            },
                            minWidth: 10.0,
                            color: Colors.white,
                            child: const Icon(Icons.image, color: Colors.grey),
                          ),
                          Expanded(
                              child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: TextFormField(
                              controller: textTextEditingController,
                              maxLines: 10,
                              minLines: 1,
                              decoration: const InputDecoration(
                                hintText: 'Type Your Message Here ..... ',
                                border: InputBorder.none,
                              ),
                            ),
                          )),
                          SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: MaterialButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (appCubit.chatImage != null) {
                                  appCubit.uploadChatImage(
                                    date: DateTime.now().toString(),
                                    text: textTextEditingController.text,
                                    reseveUid: modelUserData.uid,
                                    imageReseve: modelUserData.image,
                                    nameReseve: modelUserData.name,
                                    bioReseve: modelUserData.bio,
                                    uidReseve: modelUserData.uid,
                                    emailReseve: modelUserData.email,
                                    imageSend: appCubit.userData?.image,
                                    nameSend: appCubit.userData?.name,
                                    bioSend: appCubit.userData?.bio,
                                    uidSend: appCubit.userData?.uid,
                                    emailSend: appCubit.userData?.email,
                                  );
                                  appCubit.deleteChatImage();
                                } else {
                                  if (textTextEditingController
                                      .text.isNotEmpty) {
                                    appCubit.sendMessamge(
                                      date: DateTime.now().toString(),
                                      text: textTextEditingController.text,
                                      reseveUid: modelUserData.uid,
                                      imageReseve: modelUserData.image,
                                      nameReseve: modelUserData.name,
                                      bioReseve: modelUserData.bio,
                                      uidReseve: modelUserData.uid,
                                      emailReseve: modelUserData.email,
                                      imageSend: appCubit.userData?.image,
                                      nameSend: appCubit.userData?.name,
                                      bioSend: appCubit.userData?.bio,
                                      uidSend: appCubit.userData?.uid,
                                      emailSend: appCubit.userData?.email,
                                    );
                                  }
                                }

                                textTextEditingController.text = '';
                              },
                              minWidth: 1.0,
                              elevation: 0.0,
                              color: Colors.blueAccent,
                              child: const Icon(
                                Icons.send,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget buildIsendTo({
    required BuildContext context,
    required ChatModel chatModel,
  }) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (chatModel.chatImage != '')
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20.0),
                    topEnd: Radius.circular(20.0),
                    bottomEnd: Radius.circular(20.0),
                  ),
                ),
                child: Image(image: NetworkImage('${chatModel.chatImage}')),
              ),
            ),
          if (chatModel.text != "")
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadiusDirectional.only(
                  topStart: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                  bottomEnd: Radius.circular(10.0),
                ),
              ),
              child: Text(
                chatModel.text ?? 'Error',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
        ],
      ),
    );
  }

  Widget buildHeSend({
    required BuildContext context,
    required ChatModel chatModel,
  }) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (chatModel.chatImage != '')
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20.0),
                    topEnd: Radius.circular(20.0),
                    bottomStart: Radius.circular(20.0),
                  ),
                ),
                child: Image(image: NetworkImage('${chatModel.chatImage}')),
              ),
            ),
          if (chatModel.text != "")
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.4),
                borderRadius: const BorderRadiusDirectional.only(
                  topStart: Radius.circular(10.0),
                  topEnd: Radius.circular(10.0),
                  bottomStart: Radius.circular(10.0),
                ),
              ),
              child: Text(
                chatModel.text ?? 'Error',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
        ],
      ),
    );
  }
}
