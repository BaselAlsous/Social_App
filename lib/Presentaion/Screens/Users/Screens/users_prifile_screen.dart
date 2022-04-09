import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/Data/Constant/Method/navigation.dart';
import 'package:social_app/Data/Model/model_user_data.dart';
import 'package:social_app/Presentaion/Screens/Chat/Screen/chat_screen.dart';

class UsersProfileScreen extends StatelessWidget {
  final ModelUserData modelUserData;
  const UsersProfileScreen({Key? key, required this.modelUserData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 180.0.h ,
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
                      image: NetworkImage('${modelUserData.cover}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 55.0.r,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 50.0.r,
                    backgroundImage: NetworkImage('${modelUserData.image}'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.0.h,
          ),
          Text('${modelUserData.name}',
            style: TextStyle(fontSize: 17.0.sp),
          ),
          SizedBox(
            height: 5.0.h,
          ),
          Text('${modelUserData.bio}',
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
                  onPressed: () {},
                  child: Text(
                    'Follow',
                    style: TextStyle(
                        color: Colors.grey, fontSize: 12.0.sp),
                  ),
                ),
              ),
              SizedBox(
                width: 5.0.w,
              ),
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: () {
                    Navigation.navigationAndBack(
                        context: context,
                        page: ChatScreen(
                            modelUserData: modelUserData
                        ),
                    );
                  },
                  child: Icon(
                    Icons.chat,
                    color: Colors.grey,
                    size: 12.0.sp,
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
         )

        ],
      ),
    );
  }
}
