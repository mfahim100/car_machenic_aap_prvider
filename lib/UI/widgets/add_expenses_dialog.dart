import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/UI/widgets/custom_button.dart';
import 'package:provider_test/core/constant/const_gradient.dart';
import 'package:provider_test/core/models/task_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/providers/task_provider.dart';
import 'custom_text_field.dart';

class AddExpensesDialog extends StatelessWidget {


final TaskModel mdl;

  const AddExpensesDialog(
      {Key? key, required this.mdl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (BuildContext context, taskProvider, Widget? child) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: SizedBox(
            width: 90.w,
            height: 50.h,
            child: Container(
              decoration: ConstGradient.profileTileDecoration,
              padding: EdgeInsets.all(5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: taskProvider.addTaskExpKey,
                    child: Column(
                      children: [
                        SizedBox(height: 1.h,),
                        CustomTextField(
                          textInputType: TextInputType.number,
                            hintText: 'Total Amount',
                            labelText: 'Total Amount',
                            obscureText: false,
                            controller: taskProvider.amountController,
                            validator: taskProvider.amountValidator),
                        SizedBox(height: 2.h),

                        CustomButton(
                            text: 'Gallery',
                            color: Colors.green,
                            onPressed: (){
                              if(taskProvider.addTaskExpKey.currentState!.validate()){
                                taskProvider.getPictureFromGallery(context,mdl!);
                              }
                            },
                        ),

                        SizedBox(height: 2.h,),

                        CustomButton(
                            text: 'Camera',
                            color: Colors.green,
                            onPressed:  (){
                              if(taskProvider.addTaskExpKey.currentState!.validate()){
                                taskProvider.getPictureFromCamera(context,mdl!);
                              }
                            }),
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
