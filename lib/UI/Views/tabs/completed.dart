import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../core/models/task_model.dart';
import '../../../core/providers/task_provider.dart';
import '../../widgets/task_listtile.dart';

class Completed extends StatelessWidget {
  const Completed({Key? key}) : super(key: key);

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
                  itemCount: taskProvider.completedTasks.length,
                  itemBuilder: (context, index) {
                    TaskModel mdlTask = taskProvider.completedTasks[index];
                    String startDate = '${mdlTask.startDate!
                        .toDate()
                        .day}/${mdlTask.startDate!.toDate().month}/${mdlTask
                        .startDate!.toDate().year}';
                    String endDate = '${mdlTask.endDate!
                        .toDate()
                        .day}/${mdlTask.endDate!.toDate().month}/${mdlTask
                        .endDate!.toDate().year}';
                    return TaskListTile(
                      mdlTask: mdlTask, onPressed: () {}, dateText:'$startDate - $endDate',);
                  }),
            ),
          );
        }
    );
  }

}
