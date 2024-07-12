import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_55_database/cubits/auth/auth_cubit.dart';
import 'package:group_55_database/cubits/home/home_cubit.dart';
import 'package:group_55_database/screens/notifications/notifications_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'screens/splash/splash_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);

  String? token = await FirebaseMessaging.instance.getToken();
  print(token);

  FirebaseMessaging.onMessage.listen((event) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 3,
        channelKey: 'basic_channel',
        actionType: ActionType.DismissAction,
        title: event.notification!.title,
        body: event.notification!.body,
      ),
    );
  });

  FirebaseMessaging.onBackgroundMessage((message) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 3,
        channelKey: 'basic_channel',
        actionType: ActionType.DismissAction,
        title: message.notification!.title,
        body: message.notification!.body,
      ),
    );
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => HomeCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true),
        home: const NotificationsScreen(),
        // home: const SplashScreen(),
      ),
    );
  }
}
