import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/Business/AppCubit/app_cubit.dart';
import 'package:social_app/Presentaion/Components/custom_appbar.dart';
import 'package:social_app/Presentaion/Components/custom_loadin.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController postTextEditingController = TextEditingController();

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var appCubit = AppCubit.get(context);
        return Scaffold(
            appBar: customeAppBar(
              context: context,
              title: 'Add Post',
              action: [
                TextButton(
                  onPressed: () {
                    var date = DateTime.now();
                    if (appCubit.imagePost != null) {
                      appCubit.uploadPostImage(
                        date: date.toString(),
                        text: postTextEditingController.text,
                      );
                      postTextEditingController.text = '';
                      appCubit.imagePost = null;
                      Navigator.pop(context);
                    } else {
                      appCubit.createNewPost(
                        date: date.toString(),
                        text: postTextEditingController.text,
                      );
                      postTextEditingController.text = '';
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('POST'),
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: appCubit.userData?.image != null,
              fallback: (context) => Center(
                child: CustomLoading.spinkit,
              ),
              builder: (context) => Padding(
                padding: EdgeInsets.all(20.0.sp),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25.0.r,
                          backgroundImage:
                              NetworkImage(appCubit.userData?.image ?? ""),
                        ),
                        SizedBox(
                          width: 20.0.w,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appCubit.userData?.name ?? 'Error',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.bold,
                                height: 1.4.h,
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 10.0.h,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: postTextEditingController,
                        decoration: const InputDecoration(
                          hintText: 'What Is In Your Mind ....',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (appCubit.imagePost != null)
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 140.0.h,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                            ),
                            child: Image(
                              image: FileImage(appCubit.imagePost!),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                appCubit.deleteImagePost();
                              },
                              child: CircleAvatar(
                                radius: 15.0.r,
                                backgroundColor: Colors.blueAccent,
                                child: const Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 20.0.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              appCubit.getPostImage();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Add Photo'),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(Icons.image),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
