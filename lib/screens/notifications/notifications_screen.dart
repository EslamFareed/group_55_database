import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AwesomeNotifications().createNotification(
                content: NotificationContent(
              id: 3,
              channelKey: 'basic_channel',
              actionType: ActionType.DismissAction,
              title: 'Hello 3',
              body: 'This is my first notification!',

              //  customSound:
              // autoDismissible: true,
              // duration:
            ));
          },
          child: const Text("Show Notifications"),
        ),
      ),
    );
  }
}
