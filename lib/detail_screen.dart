import 'dart:io';

import 'package:flutter/material.dart';
/*
import 'package:webview_flutter/webview_flutter.dart';
*/

class DetailScreen extends StatefulWidget {
  static String routeName = "/register";

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

  }
  @override
  Widget build(BuildContext context) {
    final DetailArg args = ModalRoute.of(context).settings.arguments;
return Container();
   /* return WebView(
      initialUrl: args.link,
    );*/
  }
}

class DetailArg {
  final String link;

  DetailArg(this.link);
}
