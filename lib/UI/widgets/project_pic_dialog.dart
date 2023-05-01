import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/UI/widgets/custom_button.dart';
import 'package:provider_test/core/constant/const_gradient.dart';
import 'package:provider_test/core/providers/profile_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProjectPicDialog extends StatelessWidget {




  const ProjectPicDialog(
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (BuildContext context, profileProvider, Widget? child) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: SizedBox(
            width: 90.w,
            height: 40.h,
            child: Container(
              decoration: ConstGradient.profileTileDecoration,
              padding: EdgeInsets.all(5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Column(
                      children: [
                        CustomButton(
                            text: 'Gallery',
                            color: Colors.green,
                            onPressed: (){},
                        ),

                        SizedBox(height: 2.h,),

                        CustomButton(
                            text: 'Camera',
                            color: Colors.green,
                            onPressed: (){}),
                        SizedBox(height: 2.h,),
                        CustomButton(
                            text: 'Cancel',
                            color: Colors.red,
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
