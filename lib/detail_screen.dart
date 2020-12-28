import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share/share.dart';

import 'constants.dart';

class DetailScreen extends StatefulWidget {
  static String routeName = "/register";

  final RssItem list;

  DetailScreen({Key key, this.list}) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıt Ol"),
        backgroundColor: kPrimaryColor,
        actions: [IconButton(icon:Icon(Icons.share) , onPressed: (){
          Share.share(widget.list.link, subject: widget.list.title);


        })],
      ),
      body: WebView(
        initialUrl: widget.list.link,
      ),
    );
  }
}

