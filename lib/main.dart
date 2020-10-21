import 'package:facebook_login/screens/facebook_login_screen.dart';
import 'package:facebook_login/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FacebookLoginScreen(),
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        FacebookLoginScreen.routeName: (ctx) => FacebookLoginScreen()
      },
    );
  }
}
