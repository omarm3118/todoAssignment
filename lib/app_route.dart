import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/repositories/task_repository.dart';
import 'package:todo/data/services/local_services/local_database.dart';
import 'package:todo/ui/screens/add_task/add_task_screen.dart';
import 'package:todo/ui/screens/add_task/controller/add_task_cubit.dart';
import 'package:todo/ui/screens/home/controller/home_cubit.dart';
import 'package:todo/ui/screens/home/home_screen.dart';
import 'package:todo/ui/screens/notification/notification_screen.dart';

class AppRoute {
  late TaskRepository _taskRepository;
  late LocalDataBase _dataBase;

  AppRoute() {
    _dataBase = LocalDataBase();
    _taskRepository = TaskRepository(_dataBase);
  }

  Route appRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomeScreen.route:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HomeCubit(_taskRepository)..initDB(),
            child: HomeScreen(),
          ),
        );

      case AddTaskScreen.route:
        Map args = routeSettings.arguments as Map;
        BuildContext context = args['context'];
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => AddTaskCubit()),
              BlocProvider.value(value: HomeCubit.get(context))
            ],
            child: AddTaskScreen(),
          ),
        );

      case NotificationScreen.route:
        Map payload = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => NotificationScreen(
            title: payload['title'],
            body: payload['body'],
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HomeCubit(_taskRepository)..initDB(),
            child: HomeScreen(),
          ),
        );
    }
  }
}
