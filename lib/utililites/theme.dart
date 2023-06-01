import 'package:flutter/material.dart';
import 'package:task_manager/utililites/app_colors.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: AppColors.scaffoldColor,
  inputDecorationTheme: InputDecorationTheme(
    prefixIconColor: AppColors.textColor,
    suffixIconColor: AppColors.textColor,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.textColor, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
    ),
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color:AppColors.greyColor),
    backgroundColor: AppColors.scaffoldColor,
    elevation: 0,
  ),
);
