// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app/Business/LoginCubit/login_cubit.dart';
import 'package:social_app/Data/Constant/AppData/app_data.dart';
import 'package:social_app/Data/Constant/Method/navigation.dart';
import 'package:social_app/Data/Helper/cache_helper.dart';
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
                      Container(
                        height: 260.h,
                        decoration: BoxDecoration(
                          color: Colors.indigo[700],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50.r),
                            bottomRight: Radius.circular(50.r),
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 80.h),
                            SizedBox(
                              height: 100.0.h,
                              width: 100.0.w,
                              child: const Image(
                                image: AssetImage('Asset/Images/alphabet.png'),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text('Social App',
                                style: GoogleFonts.playfairDisplay(
                                  color: Colors.white,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                )),
                            SizedBox(height: 90.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 50.sp),
                              child: Form(
                                key: keyForm,
                                child: Column(
                                  children: <Widget>[
                                    CustomeTextFormField(
                                      textEditingController: emailController,
                                      labelText: 'Email',
                                      keyboardType: TextInputType.emailAddress,
                                      prefixIcon: Icons.email,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter Email';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 10.h),
                                    CustomeTextFormField(
                                      textEditingController: passwordController,
                                      labelText: 'Password',
                                      obscureText: cubit.showPasswprd,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      prefixIcon: Icons.lock,
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
                                    SizedBox(height: 30.h),
                                    ConditionalBuilder(
                                      condition:
                                          state is! LoginUsersLoadingState,
                                      fallback: (context) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      builder: (context) => SizedBox(
                                        height: 60.h,
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
                                            style: GoogleFonts.podkova(
                                              color: Colors.white,
                                              fontSize: 22.sp,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.r),
                                          ),
                                          color: Colors.indigo[700],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30.h),
                                    TextButton(
                                      onPressed: () {
                                        Navigation.navigationAndNotBack(
                                            context: context,
                                            page: const RegesterScreen());
                                      },
                                      child: Text(
                                        "don't have an account?",
                                        style: GoogleFonts.actor(
                                          color: Colors.black,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
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
