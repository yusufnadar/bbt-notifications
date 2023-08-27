import 'package:notifications/notifications/firebase_messaging_service.dart';

import 'awesome_notification_service.dart';

class NotificationService {
  static Future<void> init() async {
    await AwesomeNotificationService.init();
    FirebaseMessagingService().init();
  }
}
