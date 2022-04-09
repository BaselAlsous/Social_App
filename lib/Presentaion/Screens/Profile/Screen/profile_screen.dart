import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/Business/AppCubit/app_cubit.dart';
import 'package:social_app/Data/Constant/Method/navigation.dart';
import 'package:social_app/Data/Model/model_post.dart';
import 'package:social_app/Presentaion/Screens/Profile/Screen/update_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool imagePost = true;
  bool commentPost = false;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getpostUser();
        return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var appCubit = AppCubit.get(context);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 180.0.h,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: double.infinity,
                              height: 120.0.h,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                              ),
                              child: Image(
                                image: NetworkImage(appCubit
                                        .userData?.cover ??
                                    "https://img.freepik.com/free-photo/impressed-young-man-points-away-shows-direction-somewhere-gasps-from-wonderment_273609-27041.jpg?w=1380&t=st=1648848492~exp=1648849092~hmac=b1537bfc246dcbfd09c0cb4b5cf0a31520f6eaea87866009e350ccabcb46aee3"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0.h,
                    ),
                    Text(
                      appCubit.userData?.name ?? 'Error',
                      style: TextStyle(fontSize: 17.0.sp),
                    ),
                    SizedBox(
                      height: 5.0.h,
                    ),
                    Text(
                      appCubit.userData?.bio ?? 'Error',
                      style: TextStyle(fontSize: 12.0.sp, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5.0.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0.sp),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    'Following',
                                    style: TextStyle(
                                        fontSize: 13.0.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5.0.h,
                                  ),
                                  const Text('0'),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    'Post',
                                    style: TextStyle(
                                        fontSize: 13.0.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5.0.h,
                                  ),
                                  const Text('0'),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    'Followers',
                                    style: TextStyle(
                                        fontSize: 13.0.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5.0.h,
                                  ),
                                  const Text('0'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigation.navigationAndBack(
                                  context: context,
                                  page: const UpdateProfileScreen());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.edit),
                                SizedBox(width: 5.0.w,),
                                Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 20.0),
                      child: Container(
                        height: 1.0,
                        color: Colors.grey[300],
                      ),
                    ),
                    if (imagePost)
                      MyPosts(
                        model: appCubit.userPost,
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class MyPosts extends StatelessWidget {
  final List<PostModel> model;
  const MyPosts({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 15.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      itemCount: model.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(model[index].postImage != ''
                    ? model[index].postImage ?? ""
                    : 'https://image.shutterstock.com/shutterstock/photos/1444569020/display_1500/stock-vector-new-post-neon-text-for-video-blog-vlogging-social-media-content-vector-illustration-design-1444569020.jpg'),
                fit: BoxFit.cover,
              )),
        );
      },
    );
  }
}
