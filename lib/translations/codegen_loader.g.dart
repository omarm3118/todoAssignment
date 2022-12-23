// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "kToday": "اليوم",
  "kAddTask": "أضف مهمة",
  "kTitle": "العنوان",
  "kNote": "ملاحظة",
  "kDate": "التاريخ",
  "kRemind": "تذكير",
  "kRepeat": "تكرار",
  "kColor": "لون",
  "kMinute": "دقيقة قبل",
  "kNone": "فارغ",
  "kEnterNote": "اكتب الملاحظة..",
  "kEnterTitle": "اكتب العنوان..",
  "kAddTaskTitle": "أضف مهمة جديدة",
  "kStartTime": "وقت البداية",
  "kEndTime": "وقت النهاية"
};
static const Map<String,dynamic> en = {
  "kToday": "Today",
  "kTitle": "Title",
  "kNote": "Note",
  "kAddTask": "Add Task",
  "kDate": "Date",
  "kRemind": "Remind",
  "kRepeat": "Repeat",
  "kColor": "Color",
  "kMinute": "minuted early",
  "kNone": "None",
  "kEnterNote": "Enter note here..",
  "kEnterTitle": "Enter title here..",
  "kAddTaskTitle": "Add New Task",
  "kStartTime": "Start Time",
  "kEndTime": "End Time"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
