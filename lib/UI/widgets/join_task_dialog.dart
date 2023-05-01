import 'package:flutter/material.dart';
import 'package:provider_test/UI/widgets/custom_button.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../core/constant/const_gradient.dart';

class JoinTaskDialog extends StatelessWidget {
  final String qrValue;

  const JoinTaskDialog({Key? key, required this.qrValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 80.w,
        height: 50.h,
        decoration: ConstGradient.profileTileDecoration,
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Column(
            children: [
              Text(
                'Join Group',
                style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 4.h,
              ),
              QrImage(
                foregroundColor: Colors.white,
                data: qrValue,
                version: QrVersions.auto,
                size: 200.0,
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomButton(
                  text: 'OK',
                  color: Colors.green,
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
