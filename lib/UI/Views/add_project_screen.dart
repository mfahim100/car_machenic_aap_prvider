import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/UI/widgets/custom_button.dart';
import 'package:provider_test/core/providers/task_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../core/constant/const_colors.dart';
import '../../core/constant/const_gradient.dart';
import '../../core/constant/const_styles.dart';
import '../widgets/custom_text_field.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key}) : super(key: key);

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: 100.h,
            height: 100.h,
            decoration:ConstGradient.profileTileDecoration,
            child: Padding(
              padding: EdgeInsets.all(1.h),
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
                            'Add Project',
                            style: ConstStyles.kHeaderStyle,
                          )),
                      SizedBox(
                        height: 2.h,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Enter Project Detail',
                            style: ConstStyles.kParaStyle,
                          )),
                      SizedBox(
                        height: 1.h,
                      ),
                      Form(
                        key: taskProvider.addTaskKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextField(
                              validator: taskProvider.validateProjectName,
                              hintText: 'Enter Project Name',
                              labelText: 'Project Name',
                              obscureText: false,
                              controller: taskProvider.projectNameController,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            CustomTextField(
                              validator: taskProvider.validProjectLocation,
                              hintText: 'Enter the Project Location',
                              labelText: 'Project Location',
                              obscureText: false,
                              controller: taskProvider.projectLocationController,
                            ),
                            SizedBox(
                              height: 2.0.h,
                            ),
                            CustomTextField(
                              textInputType: TextInputType.number,
                              validator: taskProvider.validProjectCost,
                              hintText: 'Enter the project cost',
                              labelText: 'Project Cost',
                              obscureText: false,
                              controller: taskProvider.projectCostController),


                            SizedBox(height: 2.0.h),

                            CustomButton(
                                text: 'Upload Project',
                                color: ConstColor.btnColor,
                                onPressed: (){
                                  if(taskProvider.addTaskKey.currentState!.validate()){
                                    taskProvider.uploadTask(context);
                                  }
                                }
                            ),
                            SizedBox(height: 1.5.h),
                            CustomButton(
                                text: 'Cancel',
                                color: ConstColor.btnColor,
                                onPressed: (){
                                  Navigator.of(context).pop();
                                }
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
