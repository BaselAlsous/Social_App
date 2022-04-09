import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/Business/AppCubit/app_cubit.dart';
import 'package:social_app/Presentaion/Components/custom_appbar.dart';
import 'package:social_app/Presentaion/Screens/Profile/Components/custom_text_fome_field.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameTextEditingController = TextEditingController();
    TextEditingController bioTextEditingController = TextEditingController();
    TextEditingController phoneTextEditingController = TextEditingController();

    return BlocProvider(
      create: (context) => AppCubit()..getUserData(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var appCubit = AppCubit.get(context);
          nameTextEditingController.text =
              appCubit.userData?.name ?? "Error";
          bioTextEditingController.text =
              appCubit.userData?.bio ?? "Error";
          phoneTextEditingController.text =
              appCubit.userData?.phone ?? "Error";
          return Scaffold(
            appBar: customeAppBar(
              context: context,
              title: 'Update Profile',
              action: [
                TextButton(
                  onPressed: () {
                    appCubit.updateData(
                        name: nameTextEditingController.text,
                        bio: bioTextEditingController.text,
                        phone: phoneTextEditingController.text);
                  },
                  child: const Text('Update'),
                ),
                SizedBox(
                  width: 15.0.sp,
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is UpdatUserDataLoadingState)
                      LinearProgressIndicator(
                        minHeight: 5.0.h,
                      ),
                    SizedBox(
                      height: 5.0.h,
                    ),
                    SizedBox(
                      height: 180.0.h,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 120.0.h,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          appCubit.userData?.cover ?? ''),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20.0,
                                    backgroundColor: Colors.blueAccent,
                                    child: IconButton(
                                        onPressed: () {
                                          appCubit.getCoverImage();
                                        },
                                        icon: Icon(
                                          Icons.camera_alt,
                                          size: 15.0.sp,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 55.0.r,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 50.0.r,
                                  backgroundImage: NetworkImage(appCubit
                                          .userData?.image ??
                                      "https://img.freepik.com/free-photo/impressed-young-man-points-away-shows-direction-somewhere-gasps-from-wonderment_273609-27041.jpg?w=1380&t=st=1648848492~exp=1648849092~hmac=b1537bfc246dcbfd09c0cb4b5cf0a31520f6eaea87866009e350ccabcb46aee3"),
                                ),
                              ),
                              CircleAvatar(
                                radius: 20.0,
                                backgroundColor: Colors.blueAccent,
                                child: IconButton(
                                    onPressed: () {
                                      appCubit.getProfileImage();
                                    },
                                    icon: Icon(
                                      Icons.camera_alt,
                                      size: 15.0.sp,
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0.h,
                    ),
                    CustomeTextFormFieldProfile(
                      textEditingController: nameTextEditingController,
                      keyboardType: TextInputType.name,
                      labelText: 'Name',
                      prefixIcon: Icons.person,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15.0.sp,
                    ),
                    CustomeTextFormFieldProfile(
                      textEditingController: bioTextEditingController,
                      keyboardType: TextInputType.text,
                      labelText: 'Bio',
                      prefixIcon: Icons.insert_drive_file,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Bio';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15.0.sp,
                    ),
                    CustomeTextFormFieldProfile(
                      textEditingController: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      labelText: 'Phone',
                      prefixIcon: Icons.phone,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your phone';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
