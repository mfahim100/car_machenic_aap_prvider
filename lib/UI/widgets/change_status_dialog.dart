import 'package:flutter/material.dart';
import 'package:provider_test/core/constant/const_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/constant/const_gradient.dart';

class ChangeStatusDialogBox extends StatelessWidget {
  final String title;
  final String message;
  final Function() onYes;

  const ChangeStatusDialogBox(
      {Key? key,
      required this.title,
      required this.message,
      required this.onYes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: 80.w,
        height: 23.5.h,
        child: Stack(
          children: [
            Container(
              width: 80.w,
              height: 20.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.w),
                gradient: ConstGradient.dialogGradient,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    title,
                    style: ConstStyles.kTitleStyle,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Divider(
                    height: 1.h,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: ConstStyles.kMessageStyle,
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: onYes,
                      child: CircleAvatar(
                        radius: 8.w,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 7.5.w,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            radius: 7.w,
                            backgroundColor: Colors.green,
                            child: const Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: CircleAvatar(
                        radius: 8.w,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 7.5.w,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            radius: 7.w,
                            backgroundColor: Colors.red,
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
