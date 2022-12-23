import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/constants/strings.dart';
import 'package:todo/translations/locale_keys.g.dart';

import 'components/create_new_task_button.dart';
import 'components/date_field.dart';
import 'components/note_field.dart';
import 'components/remind_field.dart';
import 'components/repeat_field.dart';
import 'components/time_field.dart';
import 'components/title_field.dart';

class AddTaskScreen extends StatelessWidget {
  static const String route = 'addTaskScreen';

 final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(LocaleKeys.kAddTaskTitle.tr()),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TitleField(),
                spacer(),
                NoteField(),
                spacer(),
                DateField(),
                spacer(),
                TimeField(),
                spacer(),
                RemindField(),
                spacer(),
                RepeatField(),
                spacer(),
                CreateTaskButton(formKey:_formKey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox spacer() {
    return SizedBox(
      height: 20.h,
    );
  }
}
