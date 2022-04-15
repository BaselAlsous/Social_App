// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/Business/AppCubit/app_cubit.dart';
import 'package:social_app/Data/Constant/AppData/app_data.dart';
import 'package:social_app/Data/Constant/Theme/app_theme.dart';
import 'package:social_app/Data/Helper/cache_helper.dart';
import 'package:social_app/Presentaion/Screens/SpalshScreen/splash_screen.dart';
import 'package:social_app/Presentaion/Screens/log/Screens/login_screen.dart';
import 'package:social_app/Presentaion/Screens/log/Screens/start_page.dart';
import 'package:social_app/Presentaion/social_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // todo: Init Firebase
  await Firebase.initializeApp();
  // todo: Init Shared Preferences
  await CacheHelper.init();

  Widget widget;
  AppData.uid = CacheHelper.getdata(key: 'uid');

  if (AppData.uid == null) {
    widget = const StartPage();
  } else if (AppData.uid == 'null') {
    widget = const LoginScreen();
  } else {
    widget = const SocialLayout();
  }

  print(' --------------- uid is :- ${AppData.uid} ---------------');

  runApp(
    SocialApp(
      page: widget,
    ),
  );
}

class SocialApp extends StatelessWidget {
  final Widget? page;
  const SocialApp({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getUserData(),
      child: Sizer(
        builder: (BuildContext context, Orientation orientation,
            DeviceType deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            title: 'Social App',
            home: SplashScreen(page: page!),
          );
        },
      ),
    );
  }
}
