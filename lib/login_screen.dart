import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/preferences.dart';
import 'package:news_app/register_screen.dart';

import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseUser _firebaseUser;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/splash.jpg"),
                  SizedBox(height: 10.0),
                  usernameField(),
                  SizedBox(height: 10.0),
                  passwordField(),
                  SizedBox(height: 15.0),
                  RaisedButton(
                    color: kPrimaryColor,
                    child: Center(
                        child: Text(
                      "Giriş Yap",
                      style: TextStyle(color: Colors.white),
                    )),
                    onPressed: () async {
                      try {
                        final User user = (await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: usernameController.text,
                                    password: passwordController.text))
                            .user;
                        Preferences().setEmail(user.email);
                        Navigator.popAndPushNamed(
                            context, DashboardScreen.routeName,
                            arguments: {});
                      } on FirebaseAuthException catch (e) {
                        debugPrint(e.toString());
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("${e.message}"),
                        ));
                      }
                    },
                  ),
                  SizedBox(height: 15.0),
                  RaisedButton(
                    color: kPrimaryColor,
                    child: Center(
                        child: Text(
                      "Google ile Giriş Yap",
                      style: TextStyle(color: Colors.white),
                    )),
                    onPressed: () {
                      _googleSignIn
                          .signIn()
                          .then((GoogleSignInAccount googleUser) async {
                        print("başarılı");
    Navigator.popAndPushNamed(context, DashboardScreen.routeName,
    arguments: {});
                        final GoogleSignInAuthentication googleAuth =
                            await googleUser.authentication;
                        final GoogleAuthCredential googleAuthCredential =
                            GoogleAuthProvider.credential(
                          accessToken: googleAuth.accessToken,
                          idToken: googleAuth.idToken,
                        );
                        final UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithCredential(googleAuthCredential);
                        final user = userCredential.user;
                        Preferences().setEmail(user.email);

                      });
                    },
                  ),
                  SizedBox(height: 15.0),
                  RaisedButton(
                    onPressed: () {
                      Future.delayed(const Duration(seconds: 4), () async {
                        Navigator.pushNamed(context, RegisterScreen.routeName,
                            arguments: {});
                      });
                    },
                    color: kPrimaryColor,
                    child: Center(
                        child: Text(
                      "Kayıt Ol",
                      style: TextStyle(color: Colors.white),
                    )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextField usernameField() {
    return TextField(
      autocorrect: false,
      enableSuggestions: false,
      keyboardType: TextInputType.emailAddress,
      obscureText: false,
      controller: usernameController,
      decoration: inputDecoration("Email"),
    );
  }

  TextField passwordField() {
    return TextField(
      controller: passwordController,
      obscureText: true,
      decoration: inputDecoration("Parola"),
    );
  }
}
