import 'package:clock_app/data/enums.dart';
import 'package:clock_app/data/models/menu_info.dart';
import 'package:clock_app/views/home_page.dart';
import 'package:clock_app/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  tz.initializeTimeZones();

  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid = const AndroidInitializationSettings('app_logo');
  var initializationSettingsIOS = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
    },
  );
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        print('Notification payload: ${response.payload}');
      });

  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        // Use a FutureBuilder to show the SplashScreen while initializing the app
        future: Future.delayed(const Duration(seconds: 7)), // Change the delay duration as needed
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the future to complete, show the SplashScreen
            return SplashScreen();
          } else {
            // Once the future is completed, show the main app
            return ChangeNotifierProvider<MenuInfo>(
              create: (context) => MenuInfo(MenuType.clock),
              child: HomePage(),
            );
          }
        },
      ),
    );
  }
}
