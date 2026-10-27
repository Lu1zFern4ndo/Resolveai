import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _inicializado = false;
  int _proximoId = 0;

  static const _canal = AndroidNotificationDetails(
    'propostas',
    'Propostas',
    channelDescription: 'Avisos de propostas recebidas',
    importance: Importance.high,
    priority: Priority.high,
  );

  Future<void> init() async {
    if (_inicializado) return;

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(
      settings: const InitializationSettings(android: android),
    );

    _inicializado = true;
  }
  Future<bool> pedirPermissao() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    return await android?.requestNotificationsPermission() ?? false;
  }

  Future<void> mostrar(String titulo, String corpo) async {
    await _plugin.show(
      id: _proximoId++,
      title: titulo,
      body: corpo,
      notificationDetails: const NotificationDetails(android: _canal),
    );
  }
}