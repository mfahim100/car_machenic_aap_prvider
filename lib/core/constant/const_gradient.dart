import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_test/core/constant/const_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ConstGradient {
  static const LinearGradient mainGradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      tileMode: TileMode.repeated,
      colors: [
        ConstColor.gr1Color,
        ConstColor.gr2Color,
      ]);
  static final LinearGradient dialogGradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      tileMode: TileMode.repeated,
      colors: [
        ConstColor.gr1Color.withOpacity(.5),
        ConstColor.gr2Color.withOpacity(.5),
      ]);


  static final BoxDecoration profileTileDecoration=BoxDecoration(
    gradient: profileGradient,
      borderRadius: BorderRadius.circular(5.w),
    boxShadow: [
      BoxShadow(color: Colors.grey.shade100.withOpacity(.5),
          blurRadius: 10,
          spreadRadius: 2,
          offset: const Offset(1,3))
    ],

  );
  static final BoxDecoration mainDecoration=BoxDecoration(
    gradient: profileGradient,
    boxShadow: [
      BoxShadow(color: Colors.grey.shade100.withOpacity(.5),
          blurRadius: 10,
          spreadRadius: 2,
          offset: const Offset(1,3))
    ],

  );
  static const LinearGradient profileGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      tileMode: TileMode.repeated,
      colors: [
        ConstColor.p1Color,
        ConstColor.p2Color,
        ConstColor.p3Color,
        ConstColor.p4Color,
      ]);
}
