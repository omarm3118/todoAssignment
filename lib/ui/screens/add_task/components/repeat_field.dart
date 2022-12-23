import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/ui/screens/add_task/controller/add_task_cubit.dart';

import '../../../../constants/app_themes/app_colors/app_colors.dart';
import '../../../../constants/strings.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../widgets/text_form_field.dart';

class RepeatField extends StatelessWidget {
  RepeatField({
    Key? key,
  }) : super(key: key);
  String? _selectedRepeat;
  final List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskCubit, AddTaskState>(
      builder: (context, state) {
        _selectedRepeat = AddTaskCubit.get(context).selectedRepeat;

        return DefaultTextFormField(
          hint: _selectedRepeat!,
          hintStyle: Theme.of(context).textTheme.bodyLarge!,
          title: Text(
              LocaleKeys.kRepeat.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          isReadOnly: true,
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton(
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                style: const TextStyle(color: Colors.white),
                dropdownColor: AppColors.dropDownColor,
                borderRadius: BorderRadius.circular(kRadius.w),
                items: repeatList.map<DropdownMenuItem<String>>(
                  (value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                value: _selectedRepeat,
                onChanged: (String? value) {
                  AddTaskCubit.get(context).updateRepeat(repeat: value!);
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
