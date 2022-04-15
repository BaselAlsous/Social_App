import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final Widget page;
  const SplashScreen({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('Asset/Images/alphabet.png'),
      logoSize: 60.0,
      title: Text(
        'SocialApp',
        style: Theme.of(context).textTheme.headline1,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      showLoader: false,
      loadingText: Text(
        'Welcome in Social App',
        style: Theme.of(context).textTheme.headline5,
      ),
      durationInSeconds: 5,
      navigator: page,
    );
  }
}
