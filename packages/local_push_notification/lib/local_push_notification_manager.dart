import 'package:logger/logger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

abstract class LocalPushNotificationManager {
  Future showNotificationDaily(int id, String title, String body, int hour, int minute);
  Future cancelNotification();
}

class LocalPushNotificationManagerImpl extends LocalPushNotificationManager {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final Logger _logger;

  LocalPushNotificationManagerImpl(this._flutterLocalNotificationsPlugin, this._logger, String androidIcon) {
    _initNotifications(androidIcon);
  }

  _initNotifications(String androidIcon) {
    var initializationSettingsAndroid = AndroidInitializationSettings(androidIcon);
    var initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: _onSelectNotification);
  }

  @override
  Future showNotificationDaily(int id, String title, String body, int hour, int minute) async {
    tz.initializeTimeZones();
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails('0',
                'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime).catchError((error) {
      _logger.e('Notification Scheduled catch ERROR: ${error.toString()}');
    });
    _logger.i('new Notification Succesfully Scheduled at ${Time(hour, minute, 0).hour}');
  }

  Future cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  //
  // NotificationDetails _getPlatformChannelSpecfics() {
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //       'your channel id', 'your channel name', 'your channel description',
  //       importance: Importance.max,
  //       priority: Priority.high,
  //       ticker: 'daily message Reminder');
  //   var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  //   var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  //   return platformChannelSpecifics;
  // }

  Future _onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
    return Future.value(1);
  }

  Future _onSelectNotification(String payload) async {
    _logger.i('Notification clicked');
    return Future.value(0);
  }
}