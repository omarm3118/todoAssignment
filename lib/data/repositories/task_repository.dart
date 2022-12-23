import 'package:todo/data/models/task_model.dart';
import 'package:todo/data/services/local_services/local_database.dart';

class TaskRepository {
  final LocalDataBase _dataBase;

  TaskRepository(this._dataBase);

  Future repoInitDatabase() async {
    try {
      await _dataBase.initDatabase();
    } catch (error) {
      rethrow;
    }
  }

  Future<int?>? repoInsertToDB({required TaskModel task}) async {
    try {
      return
      await _dataBase.insertToDB(task: task);
    } catch (error) {
      rethrow;
    }
  }

  Future<List<TaskModel>?> repoReadFromDB() async {
    try {
      List<Map<String, Object?>>? rawTasks = await _dataBase.readFromDB();
      List<TaskModel> tasks = [];
      if (rawTasks != null) {
        for (var json in rawTasks) {
          tasks.add(TaskModel.fromJson(json));
        }
        return tasks;
      }
    } catch (error) {
      rethrow;
    }
    return null;
  }

  repoDeleteFromDB({required int taskId}) async {
    try {
      await _dataBase.deleteFromDB(taskId: taskId);
      await repoReadFromDB();
    } catch (error) {
      rethrow;
    }
  }

  repoUpdateDB({required TaskModel task}) async {
    try {
      await _dataBase.updateDB(task: task);
      await repoReadFromDB();
    } catch (error) {
      rethrow;
    }
  }
}
