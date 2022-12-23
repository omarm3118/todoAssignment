import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/data/models/task_model.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());

  static AddTaskCubit get(context) => BlocProvider.of<AddTaskCubit>(context);
  int selectedColorIndex = 0;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  int? selectedRemind = 5;
  String? selectedRepeat = 'None';

  void changeTaskColor(int colorIndex) {
    selectedColorIndex = colorIndex;
    emit(ChangeTaskColor());
  }

  updateDate({required DateTime date}) {
    selectedDate = date;
    emit(ChangeDate());
  }

  updateTime({required startTime, required endTime}) {
    this.startTime = startTime;
    this.endTime = endTime;
    emit(ChangeTime());
  }

  updateRemind({required int remind}) {
    selectedRemind = remind;
    emit(ChangeRemind());
  }

  updateRepeat({required String repeat}) {
    selectedRepeat = repeat;
    emit(ChangeRepeat());
  }

  getTaskInfo() {
    return TaskModel(
      title: titleController.text,
      note: noteController.text,
      startTime: startTime,
      endTime: endTime,
      color: selectedColorIndex,
      isCompleted: false,
      date: DateFormat.yMd().format(selectedDate),
      remind: selectedRemind,
      repeat: selectedRepeat,
    );

  }
}
