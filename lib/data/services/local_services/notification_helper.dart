import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo/constants/app_themes/app_colors/app_colors.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/ui/screens/notification/notification_screen.dart';

class NotificationHelper {
  static final AwesomeNotifications _awesomeNotifications =
      AwesomeNotifications();

  static Future<bool> initNotification() async {
    return await _awesomeNotifications.initialize(
      null, // 'resource://drawable/todo_icon',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: AppColors.blue,
          ledColor: Colors.white,
          importance: NotificationImportance.High,
        ),
      ],
    );
  }

  static Future<bool> _checkIfNotificationAllowed() async {
    return await _awesomeNotifications.isNotificationAllowed();
  }

  static notificationPermission({required BuildContext context}) {
    _checkIfNotificationAllowed().then((bool isAllowed) {
      if (!isAllowed) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Allow Notifications'),
                content: const Text('App would like to send notifications'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Don't Allow",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: AppColors.pink),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await _awesomeNotifications
                          .requestPermissionToSendNotifications();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Allow",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: AppColors.blue),
                    ),
                  ),
                ],
              );
            });
      }
    });
  }

  static createNotification({required TaskModel task}) async {
    String localTimeZone =
        await _awesomeNotifications.getLocalTimeZoneIdentifier();
    print(localTimeZone);
    List<Color> colors = [AppColors.blue, AppColors.pink, AppColors.orange];
    print(await _awesomeNotifications.listScheduledNotifications());
    _awesomeNotifications.createNotification(
        content: NotificationContent(
          id: task.id!,
          channelKey: 'basic_channel',
          title: task.title,
          body: task.note,
          backgroundColor: colors[task.color ?? 0],
        ),
        schedule: NotificationCalendar(
          month: task.repeat == 'Monthly' || task.repeat == "None"
              ? DateFormat.d().parse(task.date!).month
              : null,
          weekday: task.repeat == 'Weakly' || task.repeat == "None"
              ? DateFormat.d().parse(task.date!).weekday
              : null,
          hour: int.tryParse(task.startTime!.split(':')[0]),
          minute: int.tryParse(task.startTime!.split(':')[1]),
          second: 0,
          millisecond: 0,
          allowWhileIdle: true,
          repeats: task.repeat == 'None' ? false : true,
          timeZone: localTimeZone,
        ));
  }

  static  listener({
    required BuildContext context,
  }) async {
    try {
      return _awesomeNotifications.actionStream
          .listen((ReceivedAction receivedAction) {
        _awesomeNotifications.setGlobalBadgeCounter(0);

        Navigator.pushNamed(context, NotificationScreen.route, arguments: {
          'title': receivedAction.title,
          'body': receivedAction.body,
        });
      });
    } catch (error) {
    }
  }

  static deleteNotification({required int taskId}) {
    _awesomeNotifications.cancel(taskId);
  }
}
