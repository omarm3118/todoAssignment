import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../translations/locale_keys.g.dart';
import '../../../widgets/text_form_field.dart';
import '../controller/add_task_cubit.dart';

class NoteField extends StatelessWidget {
  NoteField({
    Key? key,
  }) : super(key: key);

  TextEditingController? _noteController;

  @override
  Widget build(BuildContext context) {
    _noteController = AddTaskCubit.get(context).noteController;

    return DefaultTextFormField(
      validator: (String? val) {
        if (val!.isEmpty) {
          return 'Note must not be empty';
        }
        return null;
      },
      hint: LocaleKeys.kEnterNote.tr(),
      hintStyle: Theme.of(context).textTheme.bodyLarge!,
      title: Text(
        LocaleKeys.kNote.tr(),
        style: Theme.of(context).textTheme.titleLarge,
      ),
      textEditingController: _noteController,
    );
  }
}
