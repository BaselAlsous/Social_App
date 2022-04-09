import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/Business/AppCubit/app_cubit.dart';
import 'package:social_app/Data/Model/model_post.dart';
import 'package:social_app/Data/Model/model_user_data.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 26.0.r,
                  backgroundImage: NetworkImage(postModel.image ?? ""),
                ),
                SizedBox(
                  width: 10.0.w,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(postModel.name ?? 'Error',
                        style: Theme.of(context).textTheme.button),
                    SizedBox(
                      height: 5.0.h,
                    ),
                    Text(
                      postModel.dateTime ?? "Error",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                )),
                SizedBox(
                  width: 20.0.w,
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.more_horiz)),
              ],
            ),
            SizedBox(
              height: 15.0.h,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
              child: Text(
                postModel.text ?? 'Error',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SizedBox(
              height: 15.0.h,
            ),
            if (postModel.postImage != "")
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 5.0,
                child: InkWell(
                  onDoubleTap: () {},
                  child: Image(
                    image: NetworkImage(postModel.postImage ?? 'Error'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 140.0.h,
                  ),
                ),
              ),
            SizedBox(
              height: 5.0.h,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.grey,
                            size: 18.0.sp,
                          ),
                          SizedBox(
                            width: 5.0.w,
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.comment,
                            color: Colors.grey,
                            size: 18.0.sp,
                          ),
                          SizedBox(
                            width: 5.0.w,
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0.sp),
              child: Container(
                width: double.infinity,
                color: Colors.grey[300],
                height: 1.0.h,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18.0.r,
                          backgroundImage:
                              NetworkImage(modelUserData.image ?? "Error"),
                        ),
                        SizedBox(
                          width: 15.0.w,
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
                    appCubit.likePress(postId: appCubit.postsId[index]);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.grey,
                        size: 21.0.sp,
                      ),
                      SizedBox(
                        width: 5.0.w,
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
          ],
        ),
      ),
    );
  }
}
