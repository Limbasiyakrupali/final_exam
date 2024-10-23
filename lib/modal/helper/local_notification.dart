import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationHelper {
  LocalNotificationHelper._();

  static LocalNotificationHelper localNotificationHelper =
      LocalNotificationHelper._();
  List<Map<String, dynamic>> reminders = [];
  DateTime? selectDatetime;
  TextEditingController reminderController = TextEditingController();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initializationLocalNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');

    final DarwinInitializationSettings IosinitializationSettingsDarwin =
        DarwinInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: IosinitializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    tz.initializeTimeZones();
  }

  Future<void> ShowschedualNotification(
      String remindertime, DateTime datetime) async {
    await initializationLocalNotification();

    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "SCN",
      "Schedual Notification",
      importance: Importance.max,
      priority: Priority.high,
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        "Timing Notification",
        "Notification Description",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> AlramReminder(String remindertime, DateTime datetime) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> reminder = {
      'time': remindertime,
      'datetime': datetime,
    };
    reminders.add(reminder);

    List<String> alramtimeList =
        reminders.map((e) => jsonEncode(reminder)).toList();

    preferences.setStringList('reminders', alramtimeList);
  }

  Future<void> loadReminder() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    List<String>? reminderalramList = preferences.getStringList('reminders');

    if (reminderalramList != null) {
      reminders = reminderalramList
          .map((e) => jsonDecode(e) as Map<String, dynamic>)
          .toList();
    }
  }

  Future<void> addreminder() async {
    if (reminderController.text.isNotEmpty && selectDatetime != null) {
      await ShowschedualNotification(reminderController.text, selectDatetime!);
      await AlramReminder(reminderController.text, selectDatetime!);
    }
  }
}
