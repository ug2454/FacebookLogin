import 'package:facebook_login/custom_web_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

String your_client_id = "641526579843289";
String your_redirect_url =
    "https://www.facebook.com/connect/login_success.html";
FirebaseAuth auth = FirebaseAuth.instance;

String userName;
User user;
loginWithFacebook(BuildContext context) async {
  String result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CustomWebView(
        selectedUrl:
            'https://www.facebook.com/dialog/oauth?client_id=$your_client_id&redirect_uri=$your_redirect_url&response_type=token&scope=email,public_profile,',
      ),
      maintainState: true,
    ),
  );
  if (result != null) {
    try {
      final facebookAuthCred = FacebookAuthProvider.credential(result);
      final user = await auth.signInWithCredential(facebookAuthCred);
      print("the user is " + user.user.displayName);
      userName = user.user.displayName;
    } catch (e) {}
  }
}

String get username => userName;
