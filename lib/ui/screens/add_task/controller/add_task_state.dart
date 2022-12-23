part of 'add_task_cubit.dart';

@immutable
abstract class AddTaskState {}

class AddTaskInitial extends AddTaskState {}

class ChangeTaskColor extends AddTaskState {}

class ChangeDate extends AddTaskState {}

class ChangeTime extends AddTaskState {}

class ChangeRemind extends AddTaskState {}

class ChangeRepeat extends AddTaskState {}
