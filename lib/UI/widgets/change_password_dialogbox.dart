import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/UI/widgets/custom_button.dart';
import 'package:provider_test/UI/widgets/custom_text_field.dart';
import 'package:provider_test/core/constant/const_gradient.dart';
import 'package:provider_test/core/providers/profile_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Views/home_screen.dart';

class ChangePasswordDialogBox extends StatelessWidget {




  const ChangePasswordDialogBox(
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
            height:50.h,
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
                        Form(
                          key: profileProvider.changePasswordKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                hintText: 'Enter your new password',
                                labelText: 'New Password',
                                obscureText: true,
                                controller: profileProvider.newPasswordController,
                                validator: profileProvider.newPasswordValidator,
                              ),
                              SizedBox(height: 2.h),
                              CustomTextField(
                                hintText: 'Confirm Password',
                                labelText: 'Confirm Password',
                                obscureText: true,
                                controller: profileProvider.confirmPasswordController,
                                validator: profileProvider.confirmPasswordValidator,
                              ),

                              SizedBox(height: 3.h),
                              CustomButton(
                                text: 'Change Password',
                                color: Colors.blue,
                                onPressed: () {
                                  if(profileProvider.changePasswordKey.currentState!.validate()){
                                    profileProvider.changePassword();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder){
                                      return const HomeScreen();
                                    }));

                                  }


                                },
                              ),

                              SizedBox(height: 2.h),

                              CustomButton(
                                  text: 'Cancel',
                                  color: Colors.red,
                                  onPressed: () {
                                    profileProvider.clearPasswordController();
                                    Navigator.of(context).pop();
                                  }),
                            ],
                          ),
                        ),
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
