// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Business/AppCubit/app_cubit.dart';
import 'package:social_app/Data/Constant/AppData/app_data.dart';
import 'package:social_app/Data/Constant/Method/navigation.dart';
import 'package:social_app/Data/Helper/cache_helper.dart';
import 'package:social_app/Presentaion/Screens/log/Screens/login_screen.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getUserData()
        ..getAllPost()
        ..getpostUser()
        ..getAllUser()
        ..getFollow()
        ..followDone(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var appCubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: appCubit.title[appCubit.defaultIndex]),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.grey,
                      size: 25.0,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search_outlined,
                      color: Colors.grey,
                      size: 25.0,
                    )),
                IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      CacheHelper.setData(key: 'uid', value: 'null')
                          .then((value) {
                        AppData.uid = CacheHelper.getdata(key: 'uid');
                        print(
                            "------------------------ Log Out ------------------------ uid is :- " +
                                AppData.uid);
                        Navigation.navigationAndNotBack(
                            context: context, page: const LoginScreen());
                      });
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.grey,
                      size: 25.0,
                    )),
              ],
            ),
            body: appCubit.pages[appCubit.defaultIndex],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              type: BottomNavigationBarType.fixed,
              currentIndex: appCubit.defaultIndex,
              onTap: (index) {
                appCubit.toggleNavBar(index, context);
              },
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.black,
              items: appCubit.items,
            ),
          );
        },
      ),
    );
  }
}
