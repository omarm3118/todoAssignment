import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/data/repositories/task_repository.dart';

import '../../../../data/models/task_model.dart';
import '../../../../data/services/local_services/notification_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._taskRepository) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);
  final TaskRepository _taskRepository;
  DateTime selectedDate = DateTime.now();
  List<TaskModel>? tasks = [];

  updateDate(DateTime dateTime) {
    selectedDate = dateTime;
    emit(UpdateDate());
  }

  initDB() async {
    try {
      await _taskRepository.repoInitDatabase();
      emit(CreateDBSuccess());
      await readAllTasks();
    } catch (error) {
      emit(CreateDBError());
    }
  }

  readAllTasks() async {
    try {
      tasks = await _taskRepository.repoReadFromDB();
      emit(ReadTasksSuccess());
    } catch (error) {
      print('##################### ${error}');
      emit(ReadTasksError());
    }
  }

  addTask({required TaskModel task}) async {
    try {
      var id = await _taskRepository.repoInsertToDB(task: task);
      task.id=id;
      NotificationHelper.createNotification(task: task);
      emit(AddTaskSuccess());
      await readAllTasks();
    } catch (error) {
      emit(AddTaskError());
    }
  }

  updateTask({required TaskModel task}) async {
    try {
      await _taskRepository.repoUpdateDB(task: task);
      emit(UpdateTaskSuccess());
      await readAllTasks();
    } catch (error) {
      emit(UpdateTaskSuccess());
    }
  }

  deleteTask({required int taskId}) async {
    try {
      await _taskRepository.repoDeleteFromDB(taskId: taskId);
      emit(DeleteTaskSuccess());
      await readAllTasks();
    } catch (error) {
      emit(DeleteTaskError());
    }
  }
}
