import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/translations/locale_keys.g.dart';
import 'package:todo/ui/screens/add_task/controller/add_task_cubit.dart';

import '../../../../constants/app_themes/app_colors/app_colors.dart';
import '../../../../constants/strings.dart';
import '../../../widgets/text_form_field.dart';

class RemindField extends StatelessWidget {
  RemindField({
    Key? key,
  }) : super(key: key);

  final List<int> remindList = [5, 10, 15, 20];

  int? _selectedRemind;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskCubit, AddTaskState>(
      builder: (context, state) {
        _selectedRemind = AddTaskCubit.get(context).selectedRemind;
        return DefaultTextFormField(
          hint: "$_selectedRemind ${LocaleKeys.kMinute.tr()}",
          hintStyle: Theme.of(context).textTheme.bodyLarge!,
          title: Text(
            LocaleKeys.kRemind.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          isReadOnly: true,
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton(
                items: remindList.map<DropdownMenuItem<int>>(
                  (value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text('$value'),
                    );
                  },
                ).toList(),
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                style: const TextStyle(color: Colors.white),
                dropdownColor: AppColors.dropDownColor,
                borderRadius: BorderRadius.circular(kRadius.w),
                value: _selectedRemind,
                onChanged: (int? value) {
                  AddTaskCubit.get(context).updateRemind(remind: value!);
                },
                underline: const SizedBox(),
              ),
              SizedBox(
                width: 8.w,
              )
            ],
          ),
        );
      },
    );
  }
}
