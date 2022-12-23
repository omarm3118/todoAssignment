import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo/ui/screens/add_task/controller/add_task_cubit.dart';

import '../../../../translations/locale_keys.g.dart';
import '../../../widgets/text_form_field.dart';

class TitleField extends StatelessWidget {
  TitleField({
    Key? key,
  }) : super(key: key);

  TextEditingController? _titleController;

  @override
  Widget build(BuildContext context) {
    _titleController = AddTaskCubit.get(context).titleController;
    return DefaultTextFormField(
      validator: (String? val) {
        if (val!.isEmpty) {
          return 'Title must not be empty';
        }
        return null;
      },
      hint: LocaleKeys.kEnterTitle.tr(),
      hintStyle: Theme.of(context).textTheme.bodyLarge!,
      title: Text(
        LocaleKeys.kTitle.tr(),
        style: Theme.of(context).textTheme.titleLarge,
      ),
      textEditingController: _titleController,
    );
  }
}
