import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notifications/consts/notification_consts.dart';
import 'package:notifications/views/other_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    controlTerminatedNotification();
    super.initState();
  }

  Future<void> controlTerminatedNotification() async {
    var isNotification = await FirebaseMessaging.instance.getInitialMessage();
    print(isNotification);
    if (Platform.isAndroid == true && isNotification != null) {
      Get.to(
        () => const OtherView(text: 'Uygulama tamamen kapalıyken tıklanına açıldı'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                setState(() {});
                //await Future.delayed(const Duration(seconds: 2));
                //NotificationService.sendNotification('title', 'body');
              },
              child: const Text('Set state'),
            ),
            SelectableText(Consts.userToken ?? 'Send Notification')
          ],
        ),
      ),
    );
  }
}
