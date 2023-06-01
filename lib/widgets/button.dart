// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/utililites/app_colors.dart';
import 'package:task_manager/utililites/app_style.dart';

class Button extends StatelessWidget {
  final String buttonName;
  void Function()? onPressed;
  Button({super.key, required this.buttonName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: 90.w,
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
        onPressed: onPressed,
        child: Text(
          buttonName,
          style: AppStyle.instance
              .appTextStyle(16, AppColors.scaffoldColor, FontWeight.bold),
        ),
      ),
    );
  }
}
