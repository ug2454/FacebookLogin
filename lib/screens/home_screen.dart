import 'package:facebook_login/loginWithFacebook.dart';
import 'package:facebook_login/screens/facebook_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  String name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isUserLoggedIn();
  }

  void isUserLoggedIn() {
    try {
      final user = _auth.currentUser;
      print(user);
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser);
      }
    } catch (e) {
      print(e);
    }
  }

  void signOut() async {
    _auth.signOut();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      //this will remove all the route stacks and make the landing page the root.
      Navigator.pushNamedAndRemoveUntil(context, FacebookLoginScreen.routeName,
          (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome to Facebook, ${loggedInUser.displayName} , ${loggedInUser.email}',
                style: TextStyle(color: Colors.blue, fontSize: 40.0),
              ),
              SizedBox(
                height: 40.0,
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFF063D87),
                  ),
                ),
                onPressed: signOut,
                child: Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
