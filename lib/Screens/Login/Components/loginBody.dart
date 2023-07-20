import 'package:authentication_task/Screens/Register/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../components/buttons.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../HomePage.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

TextEditingController userEmailController = TextEditingController();
TextEditingController userPasswordController = TextEditingController();

class _LoginBodyState extends State<LoginBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool emptyArea = false;

    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
///////////////////////////////////////////////////////////////////////////////////
          Padding(
            padding: const EdgeInsets.only(top: 120).r,
            child: SizedBox(
              width: 260.w,
              child: Column(
                children: [
                  Text(
                    "Login!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: mainFontSize.sp,
                      fontWeight: mainFontWeight,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Welcome back ! Login with your credentials",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: commonTextSize.sp,
                      color: lightGreyReceiptBG,
                    ),
                  ),
                ],
              ),
            ),
          ),
///////////////////////////////////////////////////////////////////////////////////

          SizedBox(width: double.infinity.w, height: 40.h),
          Form(
            key: _formKey,
            child: Column(
              children: [
///////////////////////////////////////////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.only(right: 20.0).r,
                  child: SizedBox(
                    width: 220.w,
                    height: 90.h,
                    child: TextFormField(
                      controller: userEmailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          displaySnackBar(
                              context, "enter your email", SnackBarType.error);
                          emptyArea = true;
                          return "empty";
                        }
                        return null;
                      },
                      cursorColor: textBlack,
                      style: TextStyle(fontSize: subFontSize.sp),
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: textBlack),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: textBlack),
                        ),
                        icon: const Icon(
                          Icons.email_outlined,
                          color: textBlack,
                        ),
                        labelText: "Email",
                        hintText: "abc@gmail.com",
                        labelStyle: TextStyle(
                            color: textBlack,
                            fontSize: mainFontSize.sp,
                            fontWeight: mainFontWeight),
                        hintStyle: TextStyle(
                            color: textBlack, fontSize: subFontSize.sp),
                      ),
                    ),
                  ),
                ),
///////////////////////////////////////////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.only(right: 20.0).r,
                  child: SizedBox(
                    width: 220.w,
                    height: 90.h,
                    child: TextFormField(
                      controller: userPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          displaySnackBar(context, "enter your password",
                              SnackBarType.error);
                          emptyArea = true;
                          return "empty";
                        }
                        return null;
                      },
                      cursorColor: textBlack,
                      style: TextStyle(fontSize: subFontSize.sp),
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: textBlack),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: textBlack),
                        ),
                        icon: const Icon(
                          Icons.password_outlined,
                          color: textBlack,
                        ),
                        labelText: "Password",
                        hintText: "******",
                        labelStyle: TextStyle(
                            color: textBlack,
                            fontSize: mainFontSize.sp,
                            fontWeight: mainFontWeight),
                        hintStyle: TextStyle(
                            color: textBlack, fontSize: subFontSize.sp),
                      ),
                    ),
                  ),
                ),
///////////////////////////////////////////////////////////////////////////////////
                SizedBox(height: 30.h, width: double.infinity.w),
                DefaultButton(
                    text: "Log in",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        emptyArea = false;
                      }
                      if (emptyArea == false) {
                        displaySnackBar(
                            context, "loading", SnackBarType.loading);
                        userSignInWithEmailAndPassword(
                            email: userEmailController.text,
                            password: userPasswordController.text);
                      }
                    }),
///////////////////////////////////////////////////////////////////////////////////
                SizedBox(height: 20.h, width: double.infinity.w),
                Text(
                  "Do not have an account ?",
                  style: (TextStyle(
                      color: textBlack, fontSize: commonTextSize.sp)),
                ),
///////////////////////////////////////////////////////////////////////////////////
                InkWell(
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: textBlack,
                        fontSize: commonTextSize.sp,
                        fontWeight: commonTextWeight),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Register.routeName);
                  },
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  void userSignInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        if (kDebugMode) {
          print("User logedin successfully");
          Navigator.pushNamed(context, HomePage.routeName);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
        displaySnackBar(
            context, "No user found for that email", SnackBarType.error);
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
        displaySnackBar(context, "Wrong password provided for that user",
            SnackBarType.error);
      }
    }
  }
}
