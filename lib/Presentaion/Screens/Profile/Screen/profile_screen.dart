import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/Business/AppCubit/app_cubit.dart';
import 'package:social_app/Data/Constant/Method/navigation.dart';
import 'package:social_app/Data/Model/model_post.dart';
import 'package:social_app/Presentaion/Components/custom_loadin.dart';
import 'package:social_app/Presentaion/Screens/Home/Components/custom_post_item.dart';
import 'package:social_app/Presentaion/Screens/Profile/Screen/update_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool imagePost = true;
  bool commentPost = false;
  Color imgActiveBkButton = Colors.blueAccent;
  Color imgActiveTxButton = Colors.white;
  Color comActiveBkButton = Colors.white;
  Color comActiveTxButton = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getpostUser();
        return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var appCubit = AppCubit.get(context);
            return ConditionalBuilder(
              condition: appCubit.userData != null,
              fallback: (context) => Center(
                child: CustomLoading.spinkit,
              ),
              builder: (context) => RefreshIndicator(
                onRefresh: () async {
                  appCubit.getUserData();
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30.0.h,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
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
                                  image: NetworkImage(appCubit
                                          .userData?.cover ??
                                      "https://img.freepik.com/free-photo/impressed-young-man-points-away-shows-direction-somewhere-gasps-from-wonderment_273609-27041.jpg?w=1380&t=st=1648848492~exp=1648849092~hmac=b1537bfc246dcbfd09c0cb4b5cf0a31520f6eaea87866009e350ccabcb46aee3"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 65.0,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: NetworkImage(appCubit
                                        .userData?.image ??
                                    "https://img.freepik.com/free-photo/impressed-young-man-points-away-shows-direction-somewhere-gasps-from-wonderment_273609-27041.jpg?w=1380&t=st=1648848492~exp=1648849092~hmac=b1537bfc246dcbfd09c0cb4b5cf0a31520f6eaea87866009e350ccabcb46aee3"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.0.h,
                      ),
                      Text(
                        appCubit.userData?.name ?? 'Error',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(
                        height: 1.0.h,
                      ),
                      Text(
                        appCubit.userData?.bio ?? 'Error',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(fontSize: 15.0),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 3.0.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Text(
                                      'Following',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    SizedBox(
                                      height: 2.0.h,
                                    ),
                                    Text(appCubit.following.length.toString()),
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
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    SizedBox(
                                      height: 2.0.h,
                                    ),
                                    Text(appCubit.userPost.length.toString()),
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
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    SizedBox(
                                      height: 2.0.h,
                                    ),
                                    Text(appCubit.follower.length.toString()),
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
                                  SizedBox(
                                    width: 1.0.w,
                                  ),
                                  Text(
                                    'Edit Profile',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(fontSize: 15.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0.sp),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextButton(
                              child: Text('Post Image',
                                  style: TextStyle(
                                    color: imgActiveTxButton,
                                  )),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      imgActiveBkButton)),
                              onPressed: () {
                                setState(() {
                                  imagePost = true;
                                  commentPost = false;
                                  imgActiveBkButton = Colors.blueAccent;
                                  imgActiveTxButton = Colors.white;
                                  comActiveBkButton =
                                      Theme.of(context).scaffoldBackgroundColor;
                                  comActiveTxButton = Colors.grey;
                                });
                              },
                            )),
                            SizedBox(
                              width: 1.w,
                            ),
                            Expanded(
                                child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      comActiveBkButton)),
                              child: Text('Post Commint',
                                  style: TextStyle(
                                    color: comActiveTxButton,
                                  )),
                              onPressed: () {
                                setState(() {
                                  commentPost = true;
                                  imagePost = false;
                                  comActiveBkButton = Colors.blueAccent;
                                  comActiveTxButton = Colors.white;
                                  imgActiveBkButton =
                                      Theme.of(context).scaffoldBackgroundColor;
                                  imgActiveTxButton = Colors.grey;
                                });
                              },
                            )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Container(
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                      ),
                      if (imagePost && appCubit.userPost.isNotEmpty)
                        MyImagePosts(
                          model: appCubit.userPost,
                        ),
                      if (commentPost && appCubit.userPost.isNotEmpty)
                        MyCommintPost(
                          appCubit: appCubit,
                          model: appCubit.userPost,
                        ),
                      if (appCubit.userPost.isEmpty)
                        SizedBox(
                          height: 20.0.h,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'You Dont Share Any Post',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      if (appCubit.userPost.length <= 3)
                        SizedBox(
                          height: 15.0.h,
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class MyImagePosts extends StatelessWidget {
  final List<PostModel> model;
  const MyImagePosts({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.0.w),
      child: GridView.builder(
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
          if (model[index].postImage != 'null') {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(model[index].postImage != 'null'
                        ? '${model[index].postImage}'
                        : 'Asset/Images/new_post.jpg'),
                    fit: BoxFit.cover,
                  )),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('Asset/Images/new_post.jpg'),
                    fit: BoxFit.cover,
                  )),
            );
          }
        },
      ),
    );
  }
}

class MyCommintPost extends StatelessWidget {
  final List<PostModel> model;
  final AppCubit appCubit;
  const MyCommintPost({Key? key, required this.model, required this.appCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.0.w),
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 15.0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: model.length,
        itemBuilder: (context, index) {
          return CustomePostItem(
            appCubit: appCubit,
            index: index,
            modelUserData: appCubit.userData!,
            postModel: model[index],
          );
        },
      ),
    );
  }
}
