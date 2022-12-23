import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/data/services/local_services/notification_helper.dart';
import 'package:todo/ui/screens/home/controller/home_cubit.dart';

import '../../../../constants/app_themes/app_colors/app_colors.dart';
import '../../../../constants/strings.dart';

class TaskWidget extends StatelessWidget {
  TaskWidget({
    Key? key,
    required this.task,
  }) : super(key: key);
  TaskModel task;

  final List<Color> taskColor = [
    AppColors.blue,
    AppColors.pink,
    AppColors.orange,
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (ctx) {
              return Container(
                padding: EdgeInsets.all(kPadding.r),
                height: 200.h,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _completeButton(context),
                      SizedBox(
                        height: 20.h,
                      ),
                      _deleteButton(context),
                    ],
                  ),
                ),
              );
            });
      },
      child: Container(
        decoration: BoxDecoration(
          color: taskColor[task.color ?? 0],
          borderRadius: BorderRadius.circular(kRadius),
        ),
        padding: EdgeInsets.all(kPadding.r),
        child: Row(
          children: [
            Expanded(
                child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 100.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${task.title}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          color: Colors.grey[200],
                          size: 14.sp,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          '${task.startTime} - ${task.endTime}',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      '${task.note}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
              ),
            )),
            Container(
              height: 60.h,
              width: 0.5.w,
              color: Colors.grey[200],
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task.isCompleted ?? false ? 'COMPLETED' : 'TODO',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _deleteButton(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadius),
          ),
        ),
        onPressed: () async {
          await HomeCubit.get(context).deleteTask(taskId: task.id!);
          await NotificationHelper.deleteNotification(taskId: task.id!);
          Navigator.pop(context);
        },
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              'Delete',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _completeButton(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadius),
          ),
        ),
        onPressed: () async {
          task = task..isCompleted = !task.isCompleted!;
          await HomeCubit.get(context).updateTask(task: task);
          Navigator.pop(context);
        },
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              task.isCompleted ?? false ? 'Mark As ToDo' : 'Mark As Complete',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
