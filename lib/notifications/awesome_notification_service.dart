import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:notifications/consts/notification_consts.dart';

import '../views/other_view.dart';

class AwesomeNotificationService {
  static final awesomeNotification = AwesomeNotifications();

  static Future<void> init() async {
    await initializeNotificationChannel();
    var permission = await awesomeNotification.requestPermissionToSendNotifications();
    if (permission == true) {
      awesomeNotification.setListeners(
        onActionReceivedMethod: onActionReceiveMethod,
      );
    }
  }

  static Future<void> initializeNotificationChannel() async {
    await awesomeNotification.initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: Consts.channelKey,
          channelKey: Consts.channelKey,
          channelName: Consts.channelName,
          channelShowBadge: true,
          criticalAlerts: true,
          importance: NotificationImportance.High,
          channelDescription: Consts.channelDescription,
        )
      ],
      debug: false,
    );
  }

  static Future<void> onActionReceiveMethod(ReceivedAction receivedAction) async {
    print(receivedAction.payload);
    Get.to(() => const OtherView(text: 'Uygulama ön plandayken tıkladık'));
  }
}
