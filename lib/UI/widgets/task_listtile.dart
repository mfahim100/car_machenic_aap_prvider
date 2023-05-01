import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/UI/Views/detaile_screen.dart';
import 'package:provider_test/UI/widgets/pending_project_text.dart';
import 'package:provider_test/core/providers/task_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../core/constant/const_gradient.dart';
import '../../core/models/task_model.dart';

class TaskListTile extends StatelessWidget {
  final TaskModel mdlTask;
  final Function() onPressed;
  final String dateText;

  const TaskListTile(
      {Key? key,
      required this.mdlTask,
      required this.onPressed,
      this.dateText = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0.5.h),
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: 80.w,
        height: 20.h,
        decoration:ConstGradient.profileTileDecoration,

        child: InkWell(
          onTap: () {
            Provider.of<TaskProvider>(context, listen: false)
                .getTaskExpenses(mdlTask)
                .whenComplete(() => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const DetailScreen();
                    })));
          },
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(2.5.w),
                    child: Image.asset(
                      'assets/images/task_placeholder.png',
                      height: 20.w,
                      width: 20.w,
                    ),
                  ),
                  SizedBox(
                    width: 60.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PendingProjectText(
                            text: 'Task Id: ${mdlTask.id!}'),
                        PendingProjectText(
                            text: 'P.Name: ${mdlTask.projectName!}'),
                        PendingProjectText(
                            text: 'P.Cost: ${mdlTask.projectCost!}'),
                        PendingProjectText(
                            text: 'P.Expenses: ${mdlTask.expenses!}'),
                        PendingProjectText(
                            text: 'P.Location: \n${mdlTask.projectLocation!}'),
                      ],
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: mdlTask.status != 0,
                child: Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(5.h)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurStyle: BlurStyle.normal,
                          ),
                        ],
                        gradient: const LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            tileMode: TileMode.repeated,
                            colors: [
                              Color(0xFF3f51b5),
                              Color(0xFF7e57c2),
                              Color(0xFF3949ab),
                            ]),
                      ),
                      child: PendingProjectText(text: dateText)),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: onPressed,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(5.h)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurStyle: BlurStyle.normal,
                          ),
                        ],
                        gradient: const LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            tileMode: TileMode.repeated,
                            colors: [
                              Color(0xFF4fda5f),
                              Color(0xFF4fda5f),
                              Color(0xFF4fda5f),
                            ]),
                      ),
                      child: PendingProjectText(
                          text: mdlTask.status == 0
                              ? 'On Progress'
                              : mdlTask.status == 1
                                  ? 'Complete'
                                  : 'View Detail')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
