import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guard_app/Views/screens/otp.dart';
import 'package:guard_app/services/local_notification_service.dart';
import 'package:guard_app/Views/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:guard_app/firebase_options.dart';

import 'dart:math';



Future<void> backgroundHandler(RemoteMessage message) async {
  	
	}


class Palette {
  static const Color primary = Color.fromARGB(255, 0, 0, 0);
}
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    
   LocalNotificationService.initialize();
  runApp(ProviderScope(child:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      routes:  {PinCodeVerificationScreen.routeName:(context) => PinCodeVerificationScreen()},
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: generateMaterialColor(Palette.primary),
      ),
      home: SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
