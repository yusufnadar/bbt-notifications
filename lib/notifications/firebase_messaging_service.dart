import 'dart:convert';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:notifications/consts/notification_consts.dart';
import 'package:notifications/views/other_view.dart';

class FirebaseMessagingService {
  final messaging = FirebaseMessaging.instance;
  final onMessageOpenedApp = FirebaseMessaging.onMessageOpenedApp;
  final onMessage = FirebaseMessaging.onMessage;

  Future<void> init() async {
    clickNotificationBackground();
    Consts.userToken = await messaging.getToken();
    showNotificationForeground();
    unsubscribeFromTopic();
  }

  void showNotificationForeground() {
    onMessage.listen(
      (event) {
        print(event.data);
        if (Platform.isAndroid == true) {
          // cloud messaging uygulama açıkken biz oluşturduk
          // firebase push notification uygulama açıkken biz oluşturduk
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 1,
              channelKey: Consts.channelKey,
              title: event.notification?.title ?? '',
              body: event.notification?.body ?? '',
              payload: {'data': json.encode(event.data)},
            ),
          );
        } else if (Platform.isIOS == true) {}
      },
    );
  }

  void clickNotificationBackground() {
    onMessageOpenedApp.listen(
      (event) {
        if (Platform.isAndroid == true) {
          Get.to(() => const OtherView(text: 'Uygulama arka plandayken tıkladık'));
          // cloud messaging arka plandayken tetikleniyor
        } else if (Platform.isIOS == true) {}
      },
    );
  }

  Future<void> subscribeTopic() async {
    await messaging.subscribeToTopic('futbol');
  }

  Future<void> unsubscribeFromTopic() async {
    await messaging.unsubscribeFromTopic('futbol');
  }
}
