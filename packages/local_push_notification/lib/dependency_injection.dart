import 'package:core/get_it/injection_container.dart';
import 'package:local_push_notification/local_push_notification_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';

setupPushNotificationLocator({String androidIcon}) async {
  coreLocator.registerFactory<LocalPushNotificationManager>(() => LocalPushNotificationManagerImpl(FlutterLocalNotificationsPlugin(), Logger(), androidIcon));
}