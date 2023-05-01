import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/UI/widgets/custom_button.dart';
import 'package:provider_test/core/constant/const_gradient.dart';
import 'package:provider_test/core/models/task_exp_model.dart';
import 'package:provider_test/core/providers/task_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class ShowPicDialog extends StatelessWidget {


final TaskExpModel mdl;

  const ShowPicDialog({Key? key, required this.mdl}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (BuildContext context, taskProvider, Widget? child) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: SizedBox(
            width: 90.w,
            height: 65.h,
            child: Container(
              decoration: ConstGradient.profileTileDecoration,
              padding: EdgeInsets.all(5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [

                  mdl.imgUrl != null?
                 Image(
                     height: 50.h,
                     width: 70.w,
                     image: NetworkImage(mdl.imgUrl!))
                      :
                  const Image(image: AssetImage('assets/images/task_placeholder.png')
                  ),
                  SizedBox(height: 2.h,),
                  CustomButton(text: 'Close', color: Colors.red, onPressed: (){
                    Navigator.of(context).pop();
                  }),
                ]
              ),
            ),
          ),
        );
      },
    );
  }
}
