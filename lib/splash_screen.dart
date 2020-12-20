import 'package:flutter/material.dart';

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
       /* Future.delayed(const Duration(seconds: 4), () async {
          Navigator.popAndPushNamed(context, DashboardScreen.routeName,
              arguments: {});
        });*/

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

