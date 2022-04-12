import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
        Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26.0.r,
                    backgroundImage: NetworkImage("https://img.freepik.com/free-psd/ramadan-3d-rendering-with-moon-ramadan-lights-illustration_159711-2136.jpg?size=626&ext=jpg"),
                  ),
                  SizedBox(
                    width: 10.0.w,
                  ),
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Error',
                              style: Theme.of(context).textTheme.button),
                          SizedBox(
                            height: 5.0.h,
                          ),
                          Text(
                            "Error",
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
            ),
            SizedBox(
              height: 15.0.h,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
              child: Text(
                'Error',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SizedBox(
              height: 15.0.h,
            ),
            // if (postModel.postImage != "")
              Card(

                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 0.0,
                child: InkWell(
                  onDoubleTap: () {},
                  child: Image(
                    image: NetworkImage(
                        'https://img.freepik.com/free-psd/ramadan-3d-rendering-with-moon-ramadan-lights-illustration_159711-2136.jpg?size=626&ext=jpg'),
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
                       ],
        ),
      ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 1.0,
                    style: BorderStyle.solid,
                  )
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        )
        ],
      ),
    );
  }
}
