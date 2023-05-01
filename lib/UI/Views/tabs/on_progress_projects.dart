import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/UI/widgets/change_status_dialog.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../core/models/task_model.dart';
import '../../../core/providers/task_provider.dart';
import '../../widgets/task_listtile.dart';

class OnProgressProjectsTab extends StatelessWidget {
  const OnProgressProjectsTab({Key? key}) : super(key: key);

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
                  itemCount: taskProvider.onPogressTasks.length,
                  itemBuilder: (context, index) {
                    TaskModel mdlTask = taskProvider.onPogressTasks[index];
                    String startDate = '${mdlTask.startDate
                    !.toDate()
                        .day}/${mdlTask.startDate!.toDate().month}/${mdlTask
                        .startDate!.toDate().year}';

                    return TaskListTile(
                        mdlTask: mdlTask, onPressed: () {
                      showDialog(context: context, builder: (context) {
                        return ChangeStatusDialogBox(title: 'Complete',
                            message: 'Do you want to change this task from progress to complete',
                            onYes: (){
                              TaskModel mdl=mdlTask.copyWith(status: 2,startDate:Timestamp.fromDate(DateTime.now()));
                              taskProvider.changeStatusTask(mdl);
                              Navigator.pop(context);
                            },
                        );
                      });
                    }, dateText: startDate);
                  }),
            ),
          );
        }
    );
  }

}
