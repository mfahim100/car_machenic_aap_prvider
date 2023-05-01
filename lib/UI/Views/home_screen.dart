import 'package:flutter/material.dart';
import 'package:provider_test/UI/Views/sign_in_page.dart';
import 'package:provider_test/UI/Views/sign_up_screen.dart';
import 'package:provider_test/UI/widgets/custom_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/constant/const_colors.dart';
import '../../core/constant/const_gradient.dart';
import '../../core/constant/const_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: 100.w,
      height: 100.h,
      decoration:ConstGradient.profileTileDecoration,
      child: Padding(
        padding: EdgeInsets.all(2.h),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
            decoration: ConstGradient.profileTileDecoration,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                 Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hello',
                      style: ConstStyles.kHeaderStyle,
                    )),
                 SizedBox(
                  height: 4.h,
                ),
                 Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        'this is the first page which I want to create for my experience',
                    style: ConstStyles.kParaStyle,)),
                 SizedBox(height: 4.h,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomButton(
                      text: 'Sign In',
                      color: ConstColor.btnColor,
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (builder){
                        return const SignIn();
                      }))
                    ),
                     SizedBox(
                      height: 5.h,
                    ),
                    CustomButton(
                        text: 'SignUp',
                        color: ConstColor.btnColor,
                        onPressed: () =>Navigator.of(context).push(MaterialPageRoute(builder: (builder){
                          return const SignUp();
                        }))
                            ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    ));
  }
}
