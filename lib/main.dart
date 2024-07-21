import 'package:autopulse/resources/colors.dart';
import 'package:autopulse/ui/PagesScreen.dart';
import 'package:autopulse/welcome_screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Check if the user is already logged in
  final bool isLoggedIn = await _checkLoginStatus();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

Future<bool> _checkLoginStatus() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isLoggedIn ? const PagesScreen() : const LoginScreen(),
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
          backgroundColor: Colors.transparent,
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
