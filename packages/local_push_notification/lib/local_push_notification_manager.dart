import 'package:logger/logger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
    var time = new Time(hour, minute, 0);
    await _flutterLocalNotificationsPlugin.showDailyAtTime(id, title, body, time, _getPlatformChannelSpecfics())
        .catchError((error) {
      _logger.e('Notification Scheduled catch ERROR: ${error.toString()}');
    });
    _logger.i('Notification Succesfully Scheduled at ${time.hour}: ${time.minute}');
  }

  Future cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }


  NotificationDetails _getPlatformChannelSpecfics() {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'daily message Reminder');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    return platformChannelSpecifics;
  }

  Future _onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
    return Future.value(1);
  }

  Future _onSelectNotification(String payload) async {
    _logger.i('Notification clicked');
    return Future.value(0);
  }
}