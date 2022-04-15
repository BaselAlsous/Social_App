// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Business/LoginCubit/login_cubit.dart';
import 'package:social_app/Data/Constant/AppData/app_data.dart';
import 'package:social_app/Data/Constant/Method/navigation.dart';
import 'package:social_app/Data/Helper/cache_helper.dart';
import 'package:social_app/Presentaion/Components/custom_loadin.dart';
import 'package:social_app/Presentaion/Components/custom_toast.dart';
import 'package:social_app/Presentaion/Screens/log/Components/custom_text_fome_field.dart';
import 'package:social_app/Presentaion/Screens/log/Screens/regester_screen.dart';
import 'package:social_app/Presentaion/social_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) async {
          if (state is LoginUsersErrorState) {
            await customToast(
                msg: state.error.toString(), backgroundColor: Colors.red);
          } else if (state is LoginUsersSccessState) {
            CacheHelper.setData(key: 'uid', value: state.uid).then((value) {
              AppData.uid = CacheHelper.getdata(key: 'uid');
              print('-------------- uid is :- ${AppData.uid} --------------');
              Navigation.navigationAndNotBack(
                  context: context, page: const SocialLayout());
            });
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context: context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Center(
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 70),
                            Image.asset(
                              'Asset/Images/alphabet.png',
                              width: 100.0,
                            ),
                            Text('Welcome Back!',
                                style: Theme.of(context).textTheme.headline1),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text('Please sign in to your acount',
                                style: Theme.of(context).textTheme.caption),
                            const SizedBox(height: 60),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: Form(
                                key: keyForm,
                                child: Column(
                                  children: <Widget>[
                                    CustomeTextFormField(
                                      textEditingController: emailController,
                                      labelText: 'Email',
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter Email';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    CustomeTextFormField(
                                      textEditingController: passwordController,
                                      labelText: 'Password',
                                      obscureText: cubit.showPasswprd,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      suffixIcon: cubit.showPasswprd
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      onPressed: () {
                                        cubit.showPassword();
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter Password';
                                        }
                                        return null;
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              'forgit password',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  ?.copyWith(
                                                    color: Colors.grey[500],
                                                  ),
                                            ))
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    ConditionalBuilder(
                                      condition:
                                          state is! LoginUsersLoadingState,
                                      fallback: (context) => Center(
                                        child: CustomLoading.spinkit,
                                      ),
                                      builder: (context) => SizedBox(
                                        height: 60,
                                        width: double.infinity,
                                        child: MaterialButton(
                                          onPressed: () {
                                            if (keyForm.currentState!
                                                .validate()) {
                                              cubit.loginUsers(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                              );
                                            }
                                          },
                                          child: Text(
                                            "Login",
                                            style: Theme.of(context)
                                                .textTheme
                                                .button,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ConditionalBuilder(
                                      condition: true,
                                      fallback: (context) => Center(
                                        child: CustomLoading.spinkit,
                                      ),
                                      builder: (context) => SizedBox(
                                        height: 60,
                                        width: double.infinity,
                                        child: MaterialButton(
                                          onPressed: () {
                                            if (keyForm.currentState!
                                                .validate()) {}
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const CircleAvatar(
                                                radius: 18.0,
                                                backgroundImage: NetworkImage(
                                                    'https://3.bp.blogspot.com/-5VdUbGHflNg/XCI7k-lUJHI/AAAAAAAAmFg/Y2Nbb45ILvsg7lTrkOOAFjonmzzQTpxcgCLcBGAs/s1600/Google-Logo.jpg'),
                                              ),
                                              const SizedBox(
                                                width: 5.0,
                                              ),
                                              Text(
                                                "Sign in with google",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .button
                                                    ?.copyWith(
                                                      color: Colors.black,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "don't have an account ?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        ),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigation.navigationAndNotBack(
                                                  context: context,
                                                  page: const RegesterScreen());
                                            },
                                            child: const Text('Sign up')),
                                      ],
                                    ),
                                  ],
                                ),
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
        },
      ),
    );
  }
}
