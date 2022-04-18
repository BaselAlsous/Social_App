import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/Business/AppCubit/app_cubit.dart';
import 'package:social_app/Data/Constant/Method/navigation.dart';
import 'package:social_app/Data/Model/model_post.dart';
import 'package:social_app/Data/Model/model_user_data.dart';
import 'package:social_app/Presentaion/Screens/Home/Screens/comment_screen.dart';

class CustomePostItem extends StatelessWidget {
  final ModelUserData modelUserData;
  final PostModel postModel;
  final AppCubit appCubit;
  final int index;
  const CustomePostItem({
    Key? key,
    required this.postModel,
    required this.modelUserData,
    required this.index,
    required this.appCubit,
  }) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(6.0.sp),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26.0,
                  backgroundImage: NetworkImage(postModel.image ?? ""),
                ),
                SizedBox(
                  width: 4.0.w,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Text(postModel.name ?? 'Error',
                        style: Theme.of(context).textTheme.headline5),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    Text(
                      postModel.dateTime?.substring(5, 16) ?? "Error",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(fontSize: 10.0.sp),
                    ),
                  ],
                )),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.more_horiz)),
              ],
            ),
          ),
          SizedBox(
            height: 2.0.h,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
            child: Text(
              postModel.text ?? 'Error',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SizedBox(
            height: 2.0.h,
          ),
          if (postModel.postImage != "null")
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 0.0,
              child: InkWell(
                onDoubleTap: () {},
                child: Image(
                  image: NetworkImage(postModel.postImage ?? 'Error'),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 40.0.h,
                ),
              ),
            ),
          SizedBox(
            height: 2.0.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 5.0.w),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.grey,
                          size: 15.0.sp,
                        ),
                        SizedBox(
                          width: 1.0.w,
                        ),
                        Text(
                          appCubit.allLike.length.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigation.navigationAndBack(
                          context: context,
                          page: CommentScreen(
                            index: index,
                            appCubit: appCubit,
                          ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.comment,
                          color: Colors.grey,
                          size: 15.0.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5.0.sp),
            child: Container(
              width: double.infinity,
              color: Colors.grey[300],
              height: 0.2.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(4.0.sp),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigation.navigationAndBack(
                          context: context,
                          page: CommentScreen(
                            index: index,
                            appCubit: appCubit,
                          ));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.0,
                          backgroundImage: NetworkImage(
                              modelUserData.image ?? "Error"),
                        ),
                        SizedBox(
                          width: 5.0.w,
                        ),
                        const Text(
                          'Write Comment ...',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    appCubit.sendLikePress(
                        postId: appCubit.postsId[index]);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.grey,
                        size: 17.0.sp,
                      ),
                      SizedBox(
                        width: 1.0.w,
                      ),
                      const Text(
                        'Like',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
