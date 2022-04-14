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
import 'package:social_app/Presentaion/Screens/log/Screens/login_screen.dart';
import 'package:social_app/Presentaion/social_layout.dart';

class RegesterScreen extends StatelessWidget {
  const RegesterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is RegesterUsersErrorState) {
              customToast(msg: state.error, backgroundColor: Colors.red);
            } else if (state is CreateUsersSccessState) {
              CacheHelper.setData(key: 'uid', value: state.uid).then((value) {
                AppData.uid = CacheHelper.getdata(key: 'uid');
                print(
                    ' --------------- uid is :- ${AppData.uid} ---------------');
                Navigation.navigationAndNotBack(
                    context: context, page: const SocialLayout());
              });
            }
          },
          builder: (context, state) {
            var cubit = LoginCubit.get(context: context);
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Center(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 70.h),
                            Text('Create New Acount',
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                )),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text('Please fill in the form to continue',
                                style: GoogleFonts.roboto(
                                  color: Colors.grey,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                )),
                            SizedBox(height: 60.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 35.sp),
                              child: Form(
                                key: keyForm,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    CustomeTextFormField(
                                      textEditingController: nameController,
                                      labelText: 'Your Name',
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter Name';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 10.h),
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
                                    SizedBox(height: 10.h),
                                    CustomeTextFormField(
                                      textEditingController: phoneController,
                                      labelText: 'Phone',
                                      keyboardType: TextInputType.phone,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter Phone';
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
                                    SizedBox(height: 40.h),
                                    ConditionalBuilder(
                                      condition:
                                          state is! RegesterUsersLoadingState,
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
                                              cubit.regesterUsers(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                                phone: phoneController.text,
                                                name: nameController.text,
                                              );
                                            }
                                          },
                                          child: Text(
                                            "Sign up",
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 15.sp,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "don't have an account ?",
                                          style: GoogleFonts.actor(
                                            color: Colors.black,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigation.navigationAndNotBack(
                                                  context: context,
                                                  page: const LoginScreen());
                                            },
                                            child: const Text('Sign in')),
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
            );
          },
        ),
      ),
    );
  }
}
