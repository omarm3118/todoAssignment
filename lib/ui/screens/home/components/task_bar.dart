import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo/translations/locale_keys.g.dart';

import '../../../widgets/default_button.dart';
import '../../add_task/add_task_screen.dart';

class TaskBar extends StatelessWidget {
  TaskBar({
    Key? key,
  }) : super(key: key);

  String? _currentDate;

  @override
  Widget build(BuildContext context) {
    _currentDate =
        DateFormat.yMMMMd(context.locale.toString()).format(DateTime.now());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _currentDate!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              LocaleKeys.kToday.tr(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        )),
        Expanded(
          child: DefaultButton(
            label: '+ ${LocaleKeys.kAddTask.tr()}',
            onPressed: () {
              Navigator.pushNamed(
                context,
                AddTaskScreen.route,
                arguments: {'context': context},
              );
            },
          ),
        ),
      ],
    );
  }
}
