import 'package:flutter/material.dart';
import 'package:provider_test/core/constant/const_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PendingProjectText extends StatelessWidget {
  final String text;

  const PendingProjectText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: ConstStyles.kButtonStyle.copyWith(fontSize: 15.sp
      ),
    );
  }
}
