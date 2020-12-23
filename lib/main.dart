import 'package:flutter/material.dart';
import 'package:news_app/dashboard_screen.dart';
import 'package:news_app/register_screen.dart';
import 'package:news_app/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haberler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName:(context) =>RegisterScreen(),
        DashboardScreen.routeName:(context)=>DashboardScreen(),
      },
    );
  }
}
