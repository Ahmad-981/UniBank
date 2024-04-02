import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:unibank/consts/firebase_const.dart';
import 'package:unibank/controller/auth_controller.dart';
import 'package:unibank/views/auth_screen/login_screen.dart';
import 'package:unibank/views/home_screen/home_screen.dart';
import 'package:unibank/views/notification/notification_screen.dart';

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    debugPrint('notification payload: $payload');
  }
  Get.to(() => NotificationScreen(),
      transition: Transition.leftToRightWithFade);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthController _authController = Get.put(AuthController());

  // This widget is the root of your application.
  Future<void> initializeFlutterLocalNotificationsPlugin() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveNotificationResponse);
  }

  @override
  void initState() {
    // TODO: implement initState
    initializeFlutterLocalNotificationsPlugin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          useMaterial3: true,
        ),
        home: Obx(
          () => _authController.isLoggedIn.value
              ? const HomeScreen()
              : const LoginScreen(),
        ));
  }
}
