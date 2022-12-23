import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/constants/app_themes/app_colors/app_colors.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/data/services/local_services/notification_helper.dart';
import 'package:todo/ui/screens/home/controller/home_cubit.dart';

import '../../../../translations/locale_keys.g.dart';
import '../../../widgets/default_button.dart';
import '../controller/add_task_cubit.dart';

class CreateTaskButton extends StatelessWidget {
  CreateTaskButton({Key? key, required this.formKey}) : super(key: key);

  GlobalKey<FormState> formKey;
  final List<Color> _colors = [
    AppColors.blue,
    AppColors.pink,
    AppColors.orange
  ];

  late AddTaskCubit _controller;

  @override
  Widget build(BuildContext context) {
    _controller = AddTaskCubit.get(context);

    return BlocBuilder<AddTaskCubit, AddTaskState>(
      buildWhen: (preState, curState) {
        if (curState is ChangeTaskColor) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.kColor.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Wrap(
                    children: List.generate(_colors.length, (index) {
                      return chooseColor(color: _colors[index], index: index);
                    }),
                  )
                ],
              ),
            ),
            Expanded(
              child: DefaultButton(
                label: '${LocaleKeys.kAddTask.tr()}',
                onPressed: ()  {
                  if (formKey.currentState!.validate()) {
                    TaskModel task = AddTaskCubit.get(context).getTaskInfo();
                    HomeCubit.get(context).addTask(task: task);
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  GestureDetector chooseColor(
      {required final Color color, required int index}) {
    return GestureDetector(
      onTap: () {
        _controller.changeTaskColor(index);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            height: 30.r,
            width: 30.r,
            child: _controller.selectedColorIndex == index
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 20,
                  )
                : null,
          ),
          SizedBox(
            width: 5.w,
          ),
        ],
      ),
    );
  }
}
