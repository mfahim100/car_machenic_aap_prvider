import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/UI/widgets/change_status_dialog.dart';
import 'package:provider_test/core/providers/task_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../core/models/task_model.dart';
import '../../widgets/task_listtile.dart';

class PendingProjectsTab extends StatelessWidget {
  const PendingProjectsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return Padding(
          padding: EdgeInsets.all(2.0.h),
          child: SizedBox(
            height: 100.h,
            width: 100.h,
            child: ListView.builder(
                itemCount: taskProvider.pendingTasks.length,
                itemBuilder: (context, index) {
                  TaskModel mdlTask = taskProvider.pendingTasks[index];
                  return TaskListTile(
                      mdlTask: mdlTask,
                      onPressed: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return  ChangeStatusDialogBox(
                                title: 'On Progress',
                                message:
                                    'Do you want to change this task from pending to on progress',
                                onYes: (){
                                  TaskModel mdl= mdlTask.copyWith(status: 1,startDate:Timestamp.fromDate(DateTime.now()));
                                  taskProvider.changeStatusTask(mdl);
                                  Navigator.pop(context);
                                },
                              );
                            });
                      });
                }),
          ),
        );
      },
    );
  }
}
