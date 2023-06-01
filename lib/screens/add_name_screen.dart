// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:task_manager/screens/home_screen.dart';
import 'package:task_manager/utililites/app_colors.dart';
import 'package:task_manager/utililites/app_style.dart';
import 'package:task_manager/utililites/routs.dart';
import 'package:task_manager/utililites/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNameScreen extends StatefulWidget {
  const AddNameScreen({super.key});

  @override
  State<AddNameScreen> createState() => _AddNameScreenState();
}

class _AddNameScreenState extends State<AddNameScreen> {
  final nameController = TextEditingController();

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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 100.h),
                  Lottie.asset("assets/animations/76097-welcome.json",
                      height: 300.h, width: 300.w),
                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'What can I call you?',
                      style: AppStyle.instance.appTextStyle(
                          18, AppColors.textColor, FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  TextFormField(
                    style: TextStyle(color: AppColors.textColor),
                    cursorColor: AppColors.primaryColor,
                    controller: nameController,
                    maxLength: 15,
                    decoration: const InputDecoration(
                        hintText: 'Enter your name', counterText: ""),
                  ),
                  SizedBox(height: 100.h),
                  SizedBox(
                    height: 50.h,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: AppColors.primaryColor),
                        onPressed: () async {
                          final name = nameController.text;
                          if (name.isEmpty) {
                            Utilities.instance.showMessage('Enter you name');
                          } else {
                            await addName(name);
                            Routes.instance.pushAndRemoveUntil(
                              context: context,
                              newScreen: const HomeScreen(),
                            );
                            nameController.clear();
                          }
                        },
                        child: Text(
                          'Continue',
                          style: TextStyle(
                              color: AppColors.scaffoldColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //add name to sharred prefferences
  addName(String name) async {
    SharedPreferences prefference = await SharedPreferences.getInstance();
    prefference.setString('name', name);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }
}
