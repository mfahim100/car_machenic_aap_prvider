import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/UI/widgets/custom_button.dart';
import 'package:provider_test/UI/widgets/custom_text_field.dart';
import 'package:provider_test/core/constant/const_gradient.dart';
import 'package:provider_test/core/providers/profile_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditProfileDialogBox extends StatelessWidget {




  const EditProfileDialogBox(
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
            height: 70.h,
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
                          key: profileProvider.editFormKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                  hintText: 'Name',
                                  labelText: 'Name',
                                  obscureText: false,
                                  controller: profileProvider.nameController,
                                  validator: profileProvider.nameValidator),
                              SizedBox(height: 2.h),
                              CustomTextField(
                                hintText: 'Profession',
                                labelText: 'Profession',
                                obscureText: false,
                                controller:
                                    profileProvider.professionController,
                                validator: profileProvider.professionValidator,
                              ),
                              SizedBox(height: 2.h),
                              CustomTextField(
                                hintText: 'Phone',
                                labelText: 'Phone',
                                obscureText: false,
                                controller: profileProvider.phoneNoController,
                                validator: profileProvider.phoneNoValidator,
                              ),
                              SizedBox(height: 2.h),
                              CustomTextField(
                                hintText: 'Address',
                                labelText: 'Address',
                                obscureText: false,
                                controller: profileProvider.addressController,
                                validator: profileProvider.addressValidator,
                              ),
                              SizedBox(height: 5.h),
                              CustomButton(
                                text: 'Change Data',
                                color: Colors.blue,
                                onPressed: () {
                                  if(profileProvider.editFormKey.currentState!.validate()){
                                  profileProvider.changeProfile();
                                  Navigator.of(context).pop();
                                  }


                                },
                              ),

                              SizedBox(height: 2.h),

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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
