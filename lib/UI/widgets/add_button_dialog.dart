import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/UI/Views/add_project_screen.dart';
import 'package:provider_test/UI/widgets/custom_button.dart';
import 'package:provider_test/core/constant/const_gradient.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../core/providers/task_provider.dart';

class AddButtonDialog extends StatelessWidget {
  const AddButtonDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (BuildContext context, taskProvider, Widget? child) {
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
                  Column(
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      CustomButton(
                          text: 'Add Task',
                          color: Colors.green,
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(builder: (context) {
                              return const AddProjectScreen();
                            }));

                          }),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomButton(
                          text: 'Join Task',
                          color: Colors.green,
                          onPressed: () {
                            taskProvider.permissionHandler(context);
                            Navigator.of(context).pop();                          }),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomButton(
                          text: 'Cancel',
                          color: Colors.red,
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ],
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
