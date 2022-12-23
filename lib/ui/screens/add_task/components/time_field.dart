import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/ui/screens/add_task/controller/add_task_cubit.dart';

import '../../../../translations/locale_keys.g.dart';
import '../../../widgets/text_form_field.dart';

class TimeField extends StatelessWidget {
  TimeField({
    Key? key,
  }) : super(key: key);

  String? _startTime;

  String? _endTime;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskCubit, AddTaskState>(
      builder: (context, state) {
        _startTime = AddTaskCubit.get(context).startTime;
        _endTime = AddTaskCubit.get(context).endTime;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DefaultTextFormField(
                hint: _startTime!,
                hintStyle: Theme.of(context).textTheme.bodyLarge!,
                isReadOnly: true,
                title: Text(
                  LocaleKeys.kStartTime.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                suffixIcon:  IconButton(
                  icon: const Icon(
                    Icons.access_time_outlined,
                  ),
                  onPressed: () async {
                    var startTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (startTime != null) {
                      AddTaskCubit.get(context)
                          .updateTime(startTime: startTime.format(context), endTime: _endTime);
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: DefaultTextFormField(
                hint: _endTime!,
                hintStyle: Theme.of(context).textTheme.bodyLarge!,
                isReadOnly: true,
                title: Text(
                  LocaleKeys.kEndTime.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.access_time_outlined,
                  ),
                  onPressed: () async {
                    var endTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (endTime != null) {
                      AddTaskCubit.get(context)
                          .updateTime(startTime: _startTime, endTime: endTime.format(context));
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
