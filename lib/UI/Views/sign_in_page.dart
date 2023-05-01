import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/UI/Views/sign_up_screen.dart';
import 'package:provider_test/UI/widgets/custom_button.dart';
import 'package:provider_test/core/constant/const_gradient.dart';
import 'package:provider_test/core/providers/auth_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/constant/const_colors.dart';
import '../../core/constant/const_styles.dart';
import '../widgets/custom_text_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
                  decoration:ConstGradient.profileTileDecoration,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Welcome!',
                            style: ConstStyles.kHeaderStyle,
                          )),
                      SizedBox(
                        height: 2.h,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Sign In to continue',
                            style: ConstStyles.kParaStyle,
                          )),
                      SizedBox(
                        height: 1.h,
                      ),
                      Form(
                        key: authProvider.signInKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextField(
                              validator: authProvider.validateEmail,
                              hintText: 'Enter your email',
                              labelText: 'Email',
                              obscureText: false,
                              controller: authProvider.emailController,),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            CustomTextField(
                              validator: authProvider.passwordLength,
                              hintText: 'Enter your Password',
                              labelText: 'Password',
                              obscureText: true,
                              controller: authProvider.passController,),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            CustomButton(
                                text: 'Sign In',
                                color: ConstColor.btnColor,
                                onPressed: (){
                                  if(authProvider.signInKey.currentState!.validate()){
                                    authProvider.signInFunc(context);
                                  }
                                }),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (builder) {
                                return const SignUp();
                              })),
                              child: RichText(
                                textScaleFactor: 1.1,
                                textAlign: TextAlign.center,
                                text: const TextSpan(
                                    text: 'Not Sign Up yet'),
                              ),
                            ),
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
