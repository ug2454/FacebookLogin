import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FacebookLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Phone or email',
                      hintStyle:
                          TextStyle(color: Color(0xFF9FA0A3), fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle:
                          TextStyle(color: Color(0xFF9FA0A3), fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextButton(
                    onPressed: null,
                    child: Text('Log In'),
                    splashColor: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
