import 'package:flutter/material.dart';
import 'package:provider_test/core/constant/const_gradient.dart';
import 'package:provider_test/core/constant/const_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileButtons extends StatelessWidget {
  final String txt;
  final Function() onPressed;
  final IconData icon;

  const ProfileButtons(
      {Key? key,
      required this.txt,
      required this.onPressed,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 3.w
          ),
          decoration: ConstGradient.profileTileDecoration.copyWith(borderRadius: BorderRadius.circular(3.w)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [

                SizedBox(width: 3.w,),
                Icon(icon,size: 5.w,color: Colors.white,),
                SizedBox(width: 3.w,),
                Text(txt,style: ConstStyles.kMessageStyle,)
              ],),
              Padding(
                padding:  EdgeInsets.only(right: 3.w
                ),
                child: Icon(Icons.arrow_forward_ios,size: 5.w,color: Colors.white,),
              )
            ],),
        ),
      ),
    );
  }
}
