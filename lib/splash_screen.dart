import 'package:flutter/material.dart';
import 'package:news_app/login_screen.dart';

import 'dashboard_screen.dart';
import 'preferences.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/screens";

  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Preferences().getEmail().then((email) {
      if (email.isEmpty) {
        Future.delayed(const Duration(seconds: 4), () async {
          Navigator.popAndPushNamed(context, LoginScreen.routeName,
              arguments: {});
        });
      }else{
        Future.delayed(const Duration(seconds: 4), () async {
          Navigator.popAndPushNamed(context, DashboardScreen.routeName,
              arguments: {});
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _centerContainer,
    );
  }

  Widget get _centerContainer => Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/splash.jpg"),
          ],
        ),
      );
}
