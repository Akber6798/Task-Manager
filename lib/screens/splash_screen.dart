// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/screens/add_name_screen.dart';
import 'package:task_manager/screens/home_screen.dart';
import 'package:task_manager/utililites/app_colors.dart';
import 'package:task_manager/utililites/app_style.dart';
import 'package:task_manager/utililites/routs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkingNameAvailableOrNot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset('assets/animations/70032-task-on-clipboard-2.json',
                  height: 330.h, width: 330.w),
              SizedBox(height: 10.h),
              Text(
                'Task Manager',
                style: AppStyle.instance
                    .appTextStyle(23, AppColors.textColor, FontWeight.bold),
              ),
              SizedBox(height: 80.h),
              Text(
                'Version 1.0',
                style: AppStyle.instance
                    .appTextStyle(15, AppColors.redColor, FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //to check the name is available or not
  checkingNameAvailableOrNot() {
    Timer(
      const Duration(seconds: 3),
      () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        var name = preferences.getString('name');
        if (name == null) {
          Routes.instance.pushAndRemoveUntil(
            context: context,
            newScreen: const AddNameScreen(),
          );
        } else {
          Routes.instance.pushAndRemoveUntil(
            context: context,
            newScreen: const HomeScreen(),
          );
        }
      },
    );
  }
}
