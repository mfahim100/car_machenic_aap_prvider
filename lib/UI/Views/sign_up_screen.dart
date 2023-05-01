import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/UI/Views/sign_in_page.dart';
import 'package:provider_test/UI/widgets/custom_button.dart';
import 'package:provider_test/core/providers/auth_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/constant/const_colors.dart';
import '../../core/constant/const_gradient.dart';
import '../../core/constant/const_styles.dart';
import '../widgets/custom_text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: 100.h,
            height: 100.h,
            decoration: ConstGradient.profileTileDecoration,
            child: Padding(
              padding: EdgeInsets.all(2.h),
              child: Center(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                  decoration: ConstGradient.profileTileDecoration,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Sign Up',
                            style: ConstStyles.kHeaderStyle,
                          )),
                      SizedBox(height: 1.h, ),

                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Create a new account',
                            style: ConstStyles.kParaStyle,
                          )),
                      SizedBox( height: 1.h),

                      Form(
                        key: authProvider.signupKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextField(
                              validator: authProvider.validateName,
                              hintText: 'Enter you name',
                              labelText: 'Name',
                              obscureText: false,
                              controller: authProvider.nameController,
                            ),
                            SizedBox( height: 1.5.h),
                            CustomTextField(
                              validator: authProvider.validateProfession,
                              hintText: 'Enter Profession',
                              labelText: 'Profession',
                              obscureText: false,
                              controller: authProvider.professionController,),
                            SizedBox( height: 1.5.h),
                            CustomTextField(
                              validator: authProvider.validateAddress,
                              hintText: 'Enter Address',
                              labelText: 'Address',
                              obscureText: false,
                              controller: authProvider.addressController,),
                            SizedBox( height: 1.5.h),
                            CustomTextField(
                              maxLength: 11,
                              validator: authProvider.validatePhoneNumber,
                              hintText: 'Enter Phone Number',
                              labelText: 'Phone Number',
                              obscureText: false,
                              controller: authProvider.phoneNoController,
                            ),
                            SizedBox( height: 1.5.h),
                            CustomTextField(
                              validator: authProvider.validateEmail,
                              hintText: 'Enter your email',
                              labelText: 'Email',
                              obscureText: false,
                              controller: authProvider.emailController),
                            SizedBox( height: 1.5.h),
                            CustomTextField(
                              validator: authProvider.passwordLength,
                                hintText: 'Enter your Password',
                                labelText: 'Password',
                                obscureText: true,
                              controller: authProvider.passController,),
                            SizedBox( height: 1.5.h),
                            CustomTextField(
                              validator: authProvider.confirmPassword,
                                hintText: 'Confirm Password',
                                labelText: 'Confirm Password',
                                obscureText: true,
                              controller: authProvider.confirmPasswordController,),
                            SizedBox( height: 1.5.h),
                            CustomButton(
                                text: 'Sign Up',
                                color: ConstColor.btnColor,
                                onPressed: () {
                                  if(authProvider.signupKey.currentState!.validate()){
                                    authProvider.signUpFunc(context);
                                  }
                                }),
                            SizedBox( height: 1.5.h),
                            GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (builder) {
                                return const SignIn();
                              })),
                              child: RichText(
                                textScaleFactor: 1.1,
                                textAlign: TextAlign.center,
                                text: const TextSpan(
                                    text: 'Already hava account Sign In'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
