import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share/share.dart';

import 'constants.dart';

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
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final DetailArg args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıt Ol"),
        backgroundColor: kPrimaryColor,
        actions: [IconButton(icon:Icon(Icons.share) , onPressed: (){
          Share.share(args.link, subject: args.title);


        })],
      ),
      body: WebView(
        initialUrl: args.link,
      ),
    );
  }
}

class DetailArg {
  final String link;
  final String title;

  DetailArg(this.link, this.title);
}
