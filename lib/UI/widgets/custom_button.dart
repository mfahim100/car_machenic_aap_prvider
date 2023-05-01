import 'package:flutter/material.dart';
import 'package:provider_test/core/constant/const_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function() onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.5.w)),
          ),
          backgroundColor: MaterialStateProperty.all(color),
          fixedSize: MaterialStateProperty.all(const Size(500, 50))),
      child: Text(
        text,
        style: ConstStyles.kButtonStyle,
      ),
    );
  }
}
