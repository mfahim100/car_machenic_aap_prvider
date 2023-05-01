import 'package:flutter/material.dart';
import 'package:provider_test/core/constant/const_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ConstStyles {
  static TextStyle kHeaderStyle = TextStyle(
    color: ConstColor.kWhite,
    fontSize: 25.sp,
  );
  static TextStyle kParaStyle = TextStyle(
    color: ConstColor.kWhite,
    fontSize: 15.sp,
  );
  static TextStyle kButtonStyle = TextStyle(
      color: ConstColor.kWhite,
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 2);



  static TextStyle kTitleStyle = TextStyle(
    color: ConstColor.kWhite,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold
  );
  static TextStyle kMessageStyle = TextStyle(
    color: ConstColor.kWhite,
    fontSize: 16.sp,
  );
}
