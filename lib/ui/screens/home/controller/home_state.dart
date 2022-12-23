part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}


class CreateDBSuccess extends HomeState {}
class CreateDBError extends HomeState {}

class ReadTasksSuccess extends HomeState {}
class ReadTasksError extends HomeState {}

class AddTaskSuccess extends HomeState {}
class AddTaskError extends HomeState {}

class UpdateTaskSuccess extends HomeState {}
class UpdateTaskError extends HomeState {}

class DeleteTaskSuccess extends HomeState {}
class DeleteTaskError extends HomeState {}

class UpdateDate extends HomeState {}
