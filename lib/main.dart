import 'package:autopulse/resources/colors.dart';
import 'package:autopulse/welcome_screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      // home: const SplashScreen(),
      home: LoginScreen(),
      theme: ThemeData(
        cupertinoOverrideTheme:
            CupertinoThemeData().copyWith(primaryColor: Colors.blue[400]),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.blue[100],
          selectionHandleColor: Colors.blue[100],
          selectionColor: Colors.blue[100],
        ),
        scaffoldBackgroundColor: AppColors.backgroundColor,
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent, // Your custom color
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
    );
  }
}
