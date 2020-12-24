import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/detail_screen.dart';
import 'package:news_app/feature_card.dart';
import 'package:news_app/header_search.dart';
import 'package:webfeed/webfeed.dart';

import 'constants.dart';
class DashboardScreen extends StatefulWidget {
  static String routeName = "/register";

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<RssItem> _list=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  getData();
  }
  void getData() async{
    var client = http.Client();

    // RSS feed
    //https://www.hurriyet.com.tr/rss/anasayfa
    //http://aljazeera.com.tr/rss.xml
    //https://t24.com.tr/rss
    //https://www.aa.com.tr/tr/rss/default?cat=guncel
    var response = await client
        .get('https://t24.com.tr/rss');
    var channel = RssFeed.parse(response.body);
    setState(() {
      _list=channel.items;
    });
    //print(channel.items[0].title);
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          HeaderWithSearchBox(size: size,),
          ListView.builder(
              itemCount: _list.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context,int item) {
                return FeatureCard(image: _list[item].enclosure.url,
                    text: _list[item].title,
                    press: () {
                      Navigator.pushNamed(context, DetailScreen.routeName,
                          arguments: DetailArg(_list[item].link));
                    });
              }
          )],),
      ),
     // bottomNavigationBar: BottomNavigationBar(),
    );
  }
}
class BottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: kDefaultPadding * 2,
          right: kDefaultPadding * 2,
          bottom: kDefaultPadding),
      height: 80,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: kPrimaryColor.withOpacity(0.38))
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.star,
              color: kPrimaryColor,
            ),
            onPressed: () {},
          ),
          IconButton(
              icon: Icon(Icons.local_florist, color: kPrimaryColor),
              onPressed: () {}),
          IconButton(
              icon: Icon(Icons.person, color: kPrimaryColor), onPressed: () {}),
        ],
      ),
    );
  }
}