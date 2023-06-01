// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/screens/add_name_screen.dart';
import 'package:task_manager/screens/splash_screen.dart';
import 'package:task_manager/services/db_services.dart';
import 'package:task_manager/utililites/app_colors.dart';
import 'package:task_manager/utililites/app_style.dart';
import 'package:task_manager/utililites/routs.dart';
import 'package:task_manager/utililites/utilities.dart';

class CustomDrawer extends StatelessWidget {
  final String name;
  const CustomDrawer({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.cardColor,
      child: Padding(
        padding: EdgeInsets.only(left: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.h),
            Align(
              child: Text(
                "Welcome to Task Manager",
                style: AppStyle.instance
                    .appTextStyle(20, AppColors.textColor, FontWeight.w400),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              name,
              style: AppStyle.instance
                  .appTextStyle(25, AppColors.textColor, FontWeight.bold),
            ),
            SizedBox(height: 50.h),
            ListTile(
              onTap: () {
                Routes.instance.push(
                  context: context,
                  newScreen: const AddNameScreen(),
                );
              },
              title: Text(
                "Change name",
                style: AppStyle.instance
                    .appTextStyle(20, AppColors.textColor, FontWeight.w500),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                color: AppColors.redColor,
              ),
            ),
            SizedBox(height: 10.h),
            ListTile(
              onTap: () {
                Utilities.instance.showAppAppDialogue(
                  context,
                  "Are you sure to reset everything",
                  () async {
                    await DataBaseServices.instance.deleteAllData();
                    Routes.instance.pushAndRemoveUntil(
                      context: context,
                      newScreen: const SplashScreen(),
                    );
                  },
                );
              },
              title: Text(
                "Reset Everthing",
                style: AppStyle.instance
                    .appTextStyle(20, AppColors.textColor, FontWeight.w500),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                color: AppColors.redColor,
              ),
            ),
            SizedBox(height: 350.h),
            Text(
              'Version 1.0',
              style: AppStyle.instance
                  .appTextStyle(15, AppColors.redColor, FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
