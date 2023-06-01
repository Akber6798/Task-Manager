// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/utililites/app_colors.dart';
import 'package:task_manager/utililites/app_style.dart';
import 'package:task_manager/widgets/button.dart';

class Utilities {
  static Utilities instance = Utilities();

  //to show the messages

  showMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: AppColors.textColor,
        fontSize: 16.sp);
  }

  //to show app dialogs for reset data and close app

  showAppAppDialogue(
      BuildContext context, String title, void Function()? yesFunction) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: ((context) {
        return AlertDialog(
          backgroundColor: AppColors.scaffoldColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Text(
            title,
            style: AppStyle.instance
                .appTextStyle(20, AppColors.textColor, FontWeight.w500),
          ),
          actions: [
            Button(
              buttonName: "Cancel",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Button(buttonName: "Yes", onPressed: yesFunction)
          ],
        );
      }),
    );
  }
}
