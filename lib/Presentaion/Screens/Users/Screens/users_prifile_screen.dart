import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/Data/Constant/Method/navigation.dart';
import 'package:social_app/Data/Model/model_user_data.dart';
import 'package:social_app/Presentaion/Screens/Chat/Screen/chat_screen.dart';

class UsersProfileScreen extends StatelessWidget {
  final ModelUserData modelUserData;
  const UsersProfileScreen({Key? key, required this.modelUserData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 30.0.h,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                ),
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
                      image: NetworkImage('${modelUserData.cover}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 65.0,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage('${modelUserData.image}'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1.0.h,
          ),
          Text(
            '${modelUserData.name}',
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(
            height: 1.0.h,
          ),
          Text(
            '${modelUserData.bio}',
            style:
                Theme.of(context).textTheme.caption?.copyWith(fontSize: 15.0),
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
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 2.0.h,
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
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 2.0.h,
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
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 2.0.h,
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
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ),
              SizedBox(
                width: 1.0.w,
              ),
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: () {
                    Navigation.navigationAndBack(
                      context: context,
                      page: ChatScreen(modelUserData: modelUserData),
                    );
                  },
                  child: Icon(
                    Icons.chat,
                    color: Colors.grey,
                    size: 14.0.sp,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
