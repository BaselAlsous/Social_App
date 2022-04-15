import 'package:flutter/material.dart';
import 'package:social_app/Data/Constant/Method/navigation.dart';
import 'package:social_app/Presentaion/Screens/log/Screens/login_screen.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.darken),
            fit: BoxFit.cover,
            image: const NetworkImage(
                'https://img.freepik.com/free-photo/smiling-chinese-woman-typing-text-message-scrolling-social-network-smartphone-while-drinking-takeaway-coffee-isolated-gray-wall_171337-24695.jpg?size=626&ext=jpg')),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Social App',
                style: Theme.of(context).textTheme.headline1?.copyWith(
                    color: Colors.white,
                    fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'You can communicate with friends and watch all the news anytime and anywhere',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(color: Colors.white),
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30.0,
              ),
              MaterialButton(
                height: 60.0,
                minWidth: double.infinity,
                onPressed: () {
                  Navigation.navigationAndNotBack(
                      context: context, page: const LoginScreen());
                },
                child: Text(
                  "Start",
                  style: Theme.of(context).textTheme.button,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.blueAccent,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
