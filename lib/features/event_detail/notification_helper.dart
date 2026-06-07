import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../../data/models/event.dart';

final _plugin = FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  tz_data.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Africa/Algiers'));

  const android = AndroidInitializationSettings('@mipmap/ic_launcher');
  await _plugin.initialize(const InitializationSettings(android: android));
}

Future<bool> requestNotificationPermission() async {
  final android = _plugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();
  if (android == null) return true;
  return await android.requestNotificationsPermission() ?? false;
}

int _notificationId(String eventId) => eventId.hashCode.abs() % 100000;

Future<bool> scheduleEventReminder(Event event) async {
  final now = DateTime.now();
  if (event.dateStart.isBefore(now)) return false;

  var when = event.dateStart.subtract(const Duration(hours: 1));
  if (when.isBefore(now)) {
    when = event.dateStart.subtract(const Duration(minutes: 15));
    if (when.isBefore(now)) return false;
  }

  const androidDetails = AndroidNotificationDetails(
    'event_reminders',
    'Rappels',
    channelDescription: 'Rappels pour les événements ODEJ',
    importance: Importance.high,
    priority: Priority.high,
  );

  await _plugin.zonedSchedule(
    _notificationId(event.id),
    event.title,
    event.city,
    tz.TZDateTime.from(when, tz.local),
    const NotificationDetails(android: androidDetails),
    androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );

  return true;
}

Future<void> cancelEventReminder(String eventId) async {
  await _plugin.cancel(_notificationId(eventId));
}
