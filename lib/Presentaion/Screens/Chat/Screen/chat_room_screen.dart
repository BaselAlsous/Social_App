import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/Business/AppCubit/app_cubit.dart';
import 'package:social_app/Data/Constant/Method/navigation.dart';
import 'package:social_app/Data/Model/model_user_data.dart';
import 'package:social_app/Presentaion/Screens/Chat/Screen/chat_screen.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getAllChatUser();
        return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var appCubit = AppCubit.get(context);
            var allChatUser = appCubit.allChatUser;
            return ConditionalBuilder(
              condition: allChatUser.isNotEmpty,
              fallback: (context) => Center(
                child: Text("You don't have any message" , style: Theme.of(context).textTheme.headline5,),
              ),
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildUser(
                    context: context,
                    image: allChatUser[index].image ??
                        'https://img.freepik.com/free-psd/ramadan-3d-rendering-with-moon-ramadan-lights-illustration_159711-2136.jpg?size=626&ext=jpg',
                    name: allChatUser[index].name ?? 'Error',
                    modelUserData: allChatUser[index],
                    appCubit: appCubit,
                  ),
                  itemCount: allChatUser.length,
                ),
              ),
            );
          },
        );
      }
    );
  }

  Widget buildUser({
    required BuildContext context,
    required String image,
    required String name,
    required ModelUserData modelUserData,
    required AppCubit appCubit,
  }) {
    return Column(
      children: [
        InkWell(
          onLongPress: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Row(
                      children: [
                        const Icon(
                          Icons.info,
                          color: Colors.amber,
                          size: 30.0,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Center(
                            child: Text(
                          'Warning',
                          style: Theme.of(context).textTheme.headline6,
                        )),
                      ],
                    ),
                    content: Text('Are you sure to delete Chate with  $name '),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            )),
                            Expanded(
                                child: MaterialButton(
                              onPressed: () {
                                appCubit.deleteChat(
                                    reseveUid: modelUserData.uid!);
                                Navigator.pop(context);
                              },
                              child: const Text('Ok'),
                            )),
                          ],
                        ),
                      ),
                    ],
                  );
                });
          },
          onTap: () {
            Navigation.navigationAndBack(
                context: context,
                page: ChatScreen(
                  modelUserData: modelUserData,
                ));
          },
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0.r,
                backgroundImage: NetworkImage(image),
              ),
              SizedBox(
                width: 10.0.w,
              ),
              Text(name, style: Theme.of(context).textTheme.headline6),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
        ),
      ],
    );
  }
}
