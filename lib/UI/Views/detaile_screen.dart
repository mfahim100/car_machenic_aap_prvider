import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/UI/widgets/add_expenses_dialog.dart';
import 'package:provider_test/UI/widgets/join_task_dialog.dart';
import 'package:provider_test/UI/widgets/show_pic_dialog.dart';
import 'package:provider_test/core/models/task_exp_model.dart';
import 'package:provider_test/core/providers/task_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../core/constant/const_gradient.dart';
import '../../core/constant/const_styles.dart';

class DetailScreen extends StatelessWidget {

  const DetailScreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (BuildContext context, taskProvider, Widget? child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.blueAccent,
          floatingActionButton: FloatingActionButton(
            onPressed: () =>     showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return  AddExpensesDialog(mdl: taskProvider.detailModel!,);
                }),
            child: const Icon(Icons.add),
          ),
          body: SizedBox(
            width: 100.w,
            height: 100.h,
            child: Container(
                decoration: ConstGradient.profileTileDecoration
                    .copyWith(borderRadius: BorderRadius.zero),
                padding: EdgeInsets.all(1.5.h),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(1.h),
                            width: 95.w,
                            decoration: ConstGradient.profileTileDecoration,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SafeArea(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Project Name',
                                        style: TextStyle(
                                            fontSize: 22.sp, color: Colors.white),
                                      ),
                                      IconButton(onPressed: (){
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context, builder: (context){
                                          return  JoinTaskDialog(qrValue: taskProvider.detailModel!.id!,);
                                        });
                                      }, icon: const Icon(Icons.share,color: Colors.white,)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                buildDetailProjectList(
                                    'Task Name : ', taskProvider.detailModel!.projectName!),
                                buildDetailProjectList('Project Cost : ',
                                    taskProvider.detailModel!.projectCost!.toString()),
                                buildDetailProjectList('Project Expenses : ',
                                    taskProvider.detailModel!.expenses!.toString()),
                                buildDetailProjectList('Project Location : ',
                                    taskProvider.detailModel!.projectLocation!),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 1.5.h,),

                    Container(
                      width: 95.w,
                      height: 65.h,
                      decoration: BoxDecoration(
                        gradient: ConstGradient.profileGradient,
                        borderRadius: BorderRadius.circular(3.h)
                      ),
                      child: ListView.builder(
                          itemCount: taskProvider.taskExpensesModelList.length,
                          itemBuilder: (context, index) {
                            TaskExpModel mdl =
                                taskProvider.taskExpensesModelList[index];
                            String date = '${mdl.date
                            !.toDate()
                                .day}/${mdl.date!.toDate().month}/${mdl.date!.toDate().year}';
                            return Column(
                              children: [
                                Container(
                                  height: 17.h,
                                  decoration:BoxDecoration(
                                    gradient: ConstGradient.profileGradient,
                                    borderRadius: BorderRadius.circular(3.h)
                                  ),
                                    child: Padding(
                                      padding:EdgeInsets.all(2.h),
                                      child: Stack(
                                        children: [
                                          Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                     InkWell(
                                       onTap: (){
                                         showDialog(
                                             barrierDismissible: false,
                                             context: context, builder: (context){
                                           return  ShowPicDialog(mdl: mdl);
                                         });
                                       },
                                       child: Column(
                                         children: [
                                           mdl.imgUrl != null?
                                           CircleAvatar(
                                             backgroundImage: NetworkImage(mdl.imgUrl!),
                                             radius: 13.w,
                                           )
                                               :
                                           CircleAvatar(
                                             backgroundImage:const AssetImage('assets/images/task_placeholder.png'),
                                             radius: 13.w,
                                           ),
                                         ],
                                       ),
                                     ),

                                          SizedBox(width: 5.w,),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(mdl.amount.toString(),style: TextStyle(fontSize: 20.sp,color: Colors.white),),
                                              SizedBox(height: 2.h,),
                                              Text(date,style: TextStyle(fontSize: 20.sp,color: Colors.white),),
                                            ],
                                          ),
                                  ],
                                ),
                                        ],
                                      ),
                                    ),
                                ),
                                SizedBox(height: 1.5.h,),
                              ],
                            );

                          }),
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





Widget buildDetailProjectList(String name, String val) {
  return Padding(
    padding: EdgeInsets.only(left: 3.w, right: 3.w),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: ConstStyles.kMessageStyle,
            ),
            Text(
              val,
              style: ConstStyles.kMessageStyle,
            ),
          ],
        ),
        SizedBox(
          height: 1.5.h,
        ),
      ],
    ),
  );
}
