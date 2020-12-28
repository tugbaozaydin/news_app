import 'package:flutter/material.dart';
import 'package:news_app/dashboard_screen.dart';
import 'package:news_app/detail_screen.dart';
import 'package:news_app/preferences.dart';
import 'package:news_app/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_app/search_notifier.dart';
import 'package:news_app/splash_screen.dart';
import 'package:news_app/styles.dart';
import 'package:provider/provider.dart';
import 'dark_theme_provider.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => SearchNotifier(),
    )
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String email;

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
            title: 'Haberler',
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: SplashScreen(),
            routes: {
              LoginScreen.routeName: (context) => LoginScreen(),
              RegisterScreen.routeName: (context) => RegisterScreen(),
              DashboardScreen.routeName: (context) => DashboardScreen(),
              // DetailScreen.routeName: (context) => DetailScreen()
            },
          );
        },
      ),
    );
  }
}
