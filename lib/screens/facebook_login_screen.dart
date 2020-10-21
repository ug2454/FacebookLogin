import 'package:facebook_login/loginWithFacebook.dart';
import 'package:facebook_login/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class FacebookLoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  @override
  _FacebookLoginScreenState createState() => _FacebookLoginScreenState();
}

class _FacebookLoginScreenState extends State<FacebookLoginScreen> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  bool showSpinner = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isUserLoggedIn();
  }

  void isUserLoggedIn() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 300.0,
                color: Color(0xFF063D87),
                child: Center(
                  child: Icon(
                    FontAwesomeIcons.facebook,
                    color: Colors.white,
                    size: 80.0,
                  ),
                ),
              ),
              SizedBox(
                height: 80.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      TextFormField(
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction.next,
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Phone or email',
                          hintStyle: TextStyle(
                              color: Color(0xFF9FA0A3), fontSize: 20.0),
                        ),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        focusNode: _passwordFocusNode,
                        controller: passwordController,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                              color: Color(0xFF9FA0A3), fontSize: 20.0),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: null,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Log In',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0XFF286ECF)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Color(0xFF1878F3),
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            color: Colors.grey,
                            width: 150.0,
                            height: 1.0,
                          ),
                          Text('OR'),
                          Container(
                            color: Colors.grey,
                            width: 150.0,
                            height: 1.0,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        width: double.infinity,
                        child: FacebookSignInButton(
                          onPressed: () {
                            loginWithFacebook(context).whenComplete(() {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return HomeScreen();
                                  },
                                ),
                              );
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
