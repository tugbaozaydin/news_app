import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/detail_screen.dart';
import 'package:news_app/feature_card.dart';
import 'package:news_app/header_search.dart';
import 'package:news_app/preferences.dart';
import 'package:webfeed/webfeed.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'dark_theme_provider.dart';
import 'preferences.dart';

class DashboardScreen extends StatefulWidget {
  static String routeName = "/register";

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<RssItem> _list = [];
  String newName = "T 24";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    var client = http.Client();

    // RSS feed
    //https://www.hurriyet.com.tr/rss/anasayfa
    //http://aljazeera.com.tr/rss.xml
    //https://t24.com.tr/rss
    //https://www.aa.com.tr/tr/rss/default?cat=guncel

    var news = "";
    Preferences().getNewsLink().then((value) async {
      print(value);
      value.isNotEmpty ? news = value : news = 'https://t24.com.tr/rss';
      var response = await client.get(news);
      var channel = RssFeed.parse(response.body);
      setState(() {
        _list = channel.items;
      });
    });
    Preferences().getNews().then((value) => newName = value);

    //print(channel.items[0].title);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        /*leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),*/
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Ayarlar'),
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
            ),
            ListTile(
              title: Text('Hürriyet'),
              onTap: () {
                Preferences()
                    .setNewsLink("https://www.hurriyet.com.tr/rss/anasayfa");
                Preferences().setNews("Hürriyet");
                Navigator.pop(context);
                getData();
              },
            ),
            ListTile(
              title: Text('Anadolu Alansı'),
              onTap: () {
                Preferences().setNewsLink(
                    "https://www.aa.com.tr/tr/rss/default?cat=guncel");
                Preferences().setNews("AA");
                Navigator.pop(context);
                getData();
              },
            ),
            ListTile(
              title: Text('T 24'),
              onTap: () {
                Preferences().setNewsLink("https://t24.com.tr/rss");
                Preferences().setNews("T 24");
                Navigator.pop(context);
                getData();
              },
            ),
            ListTile(
              title: Text('Mod'),
              trailing: Checkbox(
                  value: themeChange.darkTheme,
                  onChanged: (bool value) {
                    themeChange.darkTheme = value;
                  }),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Lisanslar'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Version'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Geliştirici Hakkında'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Çıkış Yap'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWithSearchBox(
              title: newName,
              size: size,
            ),
            ListView.builder(
                itemCount: _list.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int item) {
                  return FeatureCard(
                      image: newName == "AA"
                          ? _list[item].imageUrl
                          : _list[item].enclosure.url,
                      text: _list[item].title,
                      press: () {
                        Navigator.pushNamed(context, DetailScreen.routeName,
                            arguments:
                                DetailArg(_list[item].link, _list[item].title));
                      });
                })
          ],
        ),
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
