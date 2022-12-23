import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/ui/screens/add_task/controller/add_task_cubit.dart';

import '../../../../translations/locale_keys.g.dart';
import '../../../widgets/text_form_field.dart';

class DateField extends StatelessWidget {
  DateField({
    Key? key,
  }) : super(key: key);

  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskCubit, AddTaskState>(
      builder: (context, state) {
        _selectedDate = AddTaskCubit.get(context).selectedDate;

        return DefaultTextFormField(
          hint: DateFormat.yMd().format(_selectedDate!),
          hintStyle: Theme.of(context).textTheme.bodyLarge!,
          isReadOnly: true,
          title: Text(
            LocaleKeys.kDate.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.calendar_today_outlined,
            ),
            onPressed: () async {
              DateTime? dateTime = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030));
              if (dateTime != null) {
                AddTaskCubit.get(context).updateDate(date: dateTime);
              }
            },
          ),
        );
      },
    );
  }
}
