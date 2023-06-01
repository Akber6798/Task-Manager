import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static AppStyle instance = AppStyle();
  TextStyle appTextStyle(double fSize, Color fColor, FontWeight fWeight) {
    return GoogleFonts.roboto(
        fontSize: fSize.sp, color: fColor, fontWeight: fWeight);
  }

  TextStyle appTextTaskStyle(double fSize, Color fColor, FontWeight fWeight,
      TextDecoration decoration) {
    return GoogleFonts.roboto(
        fontSize: fSize.sp,
        color: fColor,
        fontWeight: fWeight,
        decoration: decoration);
  }
}
