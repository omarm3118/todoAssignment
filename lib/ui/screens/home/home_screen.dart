import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:todo/constants/app_themes/app_colors/app_colors.dart'
    as my_colors;
import 'package:todo/constants/strings.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/data/services/local_services/notification_helper.dart';
import 'package:todo/ui/controller/theme_cubit.dart';
import 'package:todo/ui/screens/home/controller/home_cubit.dart';

import '../../widgets/conditional_builder.dart';
import 'components/placeholder.dart';
import 'components/task_bar.dart';
import 'components/task_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const String route = '/';
  late bool checkIfHasNotElements;

  @override
  Widget build(BuildContext context) {
    NotificationHelper.notificationPermission(context: context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.brightness_medium_outlined),
          onPressed: () {
            ThemeCubit.get(context).switchTheme();
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
             if(context.locale.toString()=='en'){
               context.setLocale(const Locale('ar'));
             }else{
               context.setLocale(const Locale('en'));

             }
              }, icon: const Icon(Icons.language_outlined)),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          HomeCubit homeCubit = HomeCubit.get(context);
          checkIfHasNotElements = true;
          return Padding(
            padding: EdgeInsets.all(kPadding.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TaskBar(),
                dateBar(context),
                ConditionalBuilder(
                  successWidget: (BuildContext context) {
                    List<TaskModel>? tasks = homeCubit.tasks;
                    DateTime selectedDate = homeCubit.selectedDate;

                    return Expanded(
                      child: Column(
                        //   mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 50.h,
                          ),
                          Expanded(
                            child: AnimationLimiter(
                              child: ListView.separated(
                                itemCount: tasks?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  return ConditionalBuilder(
                                    successWidget: (_) =>
                                        buildTasks(index, tasks),
                                    fallbackWidget: (BuildContext context) {
                                      return checkIfHasNotElements &&
                                              index == tasks.length - 1
                                          ? const NoContentPlaceholder()
                                          : const SizedBox();
                                    },
                                    condition: checkIfHas(
                                      tasks![index],
                                      selectedDate,
                                    ),
                                  );
                                },
                                shrinkWrap: true,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        SizedBox(
                                  height: 10.h,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  fallbackWidget: (BuildContext context) {
                    return const NoContentPlaceholder();
                  },
                  condition: homeCubit.tasks!.isNotEmpty,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  AnimationConfiguration buildTasks(int index, List<TaskModel> tasks) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 700),
      child: SlideAnimation(
        horizontalOffset: 50.0,
        duration: const Duration(milliseconds: 600),
        child: FadeInAnimation(
          child: TaskWidget(
            task: tasks[index],
          ),
        ),
      ),
    );
  }

  DatePicker dateBar(BuildContext context) {
    return DatePicker(
      DateTime.now(),
      initialSelectedDate: DateTime.now(),
      height: 100.h,
      width: 60.w,
      locale: context.locale.toString(),
      dateTextStyle: Theme.of(context).textTheme.titleLarge!,
      selectedTextColor: my_colors.AppColors.blue,
      selectionColor: Colors.grey.shade200.withOpacity(0.7),
      dayTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 12.sp,
          ),
      monthTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 12.sp,
          ),
      onDateChange: HomeCubit.get(context).updateDate,
    );
  }

  bool conditionDate(TaskModel task, DateTime selectedDate) {
    return (task.repeat == 'Daily' ||
        task.date == DateFormat.yMd().format(selectedDate) ||
        (task.repeat == 'Weekly' &&
            selectedDate.difference(DateFormat.yMd().parse(task.date!)).inDays %
                    7 ==
                0) ||
        (task.repeat == 'Monthly' &&
            DateFormat.yMd().parse(task.date!).day == selectedDate.day));
  }

  checkIfHas(TaskModel task, DateTime selectedDate) {
    if (conditionDate(task, selectedDate)) {
      checkIfHasNotElements = false;
    }
    return conditionDate(task, selectedDate);
  }
}
