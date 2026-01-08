import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _plugin.initialize(settings);
    _initialized = true;
  }

  Future<bool> requestPermissions() async {
    if (kIsWeb) return false;
    var granted = true;

    final ios =
        _plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    if (ios != null) {
      final result = await ios.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      if (result != null) {
        granted = granted && result;
      }
    }

    final android =
        _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      final result = await android.requestNotificationsPermission();
      if (result != null) {
        granted = granted && result;
      }
    }

    return granted;
  }

  Future<void> show({
    required int id,
    required String title,
    required String body,
  }) async {
    await init();
    const androidDetails = AndroidNotificationDetails(
      'maintenance_alerts',
      'Maintenance Alerts',
      channelDescription: 'Component wear and replacement alerts',
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    await _plugin.show(
      id,
      title,
      body,
      const NotificationDetails(android: androidDetails, iOS: iosDetails),
    );
  }
}
