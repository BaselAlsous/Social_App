// ignore_for_file: avoid_print

import 'package:card_loading/card_loading.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Business/AppCubit/app_cubit.dart';
import 'package:social_app/Presentaion/Components/custom_toast.dart';
import 'package:social_app/Presentaion/Screens/Home/Components/custom_post_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            AppCubit appCubit = AppCubit.get(context);
            String? verify = appCubit.userData?.verifyEmail;
            return RefreshIndicator(
              onRefresh: ()async{
                appCubit.getAllPost();
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    if (verify == 'false')
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        height: 50.0,
                        color: Colors.amber.withOpacity(0.6),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outline),
                            const SizedBox(width: 20.0),
                            const Expanded(
                              child: Text('Please Verify Your Email'),
                            ),
                            TextButton(
                              onPressed: () async {
                                try {
                                  await FirebaseAuth.instance.currentUser
                                      ?.sendEmailVerification()
                                      .then((value) {
                                    appCubit.verifyEmail();
                                    customToast(
                                        msg: 'Send Complete ',
                                        backgroundColor: Colors.green);
                                  }).catchError((error) {
                                    customToast(
                                        msg: 'Something Error',
                                        backgroundColor: Colors.red);
                                  });
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: const Text('Send'),
                            ),
                          ],
                        ),
                      ),
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10.0,
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: const [
                          Image(
                            image: NetworkImage(
                                'https://img.freepik.com/free-photo/teen-girl-portrait-close-up_23-2149231222.jpg?t=st=1648827180~exp=1648827780~hmac=eb67d2f0361d69efb6f8a351d74047d9ff65a19210abdbfb3973f9b1797a2876&w=1060'),
                            width: double.infinity,
                            height: 150.0,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Communicate With Friends',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ConditionalBuilder(
                      condition: appCubit.posts.isNotEmpty,
                      builder: (context) => ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => CustomePostItem(
                                postModel: appCubit.posts[index],
                                modelUserData: appCubit.userData!,
                                appCubit: appCubit,
                                index: index,
                              ),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10.0,
                              ),
                          itemCount: appCubit.posts.length),
                      fallback: (context) => ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                CardLoading(
                                  height: 30,
                                  borderRadius: 15,
                                  width: 100,
                                  margin: EdgeInsets.only(bottom: 10),
                                ),
                                CardLoading(
                                  height: 100,
                                  borderRadius: 15,
                                  margin: EdgeInsets.only(bottom: 10),
                                ),
                                CardLoading(
                                  height: 30,
                                  width: 200,
                                  borderRadius: 15,
                                  margin: EdgeInsets.only(bottom: 10),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            );
          },
        );
  }
}
