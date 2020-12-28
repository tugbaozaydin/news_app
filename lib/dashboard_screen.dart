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
import 'login_screen.dart';
import 'preferences.dart';
import 'package:package_info/package_info.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardScreen extends StatefulWidget {
  static String routeName = "/register";

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<RssItem> _list = [];
  String newName = "T 24";
  String version;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        version = packageInfo.version;
      });
    });
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
                showLicensePage(context: context);
              },
            ),
            ListTile(
              title: Text('Version $version'),
            ),
            ListTile(
              title: Text('Geliştirici Hakkında'),
              subtitle: Text("Tuğba Özaydın"),
            ),
            ListTile(
              title: Text('Çıkış Yap'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.popAndPushNamed(context, LoginScreen.routeName,
                    arguments: {});
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(list: _list[item]),

                          ),
                        );
                      });
                })
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(),
    );
  }

  void showLicensePage({
    @required BuildContext context,
    String applicationName,
    String applicationVersion,
    Widget applicationIcon,
    String applicationLegalese,
    bool useRootNavigator = false,
  }) {
    assert(context != null);
    assert(useRootNavigator != null);
    Navigator.of(context, rootNavigator: useRootNavigator)
        .push(MaterialPageRoute<void>(
      builder: (BuildContext context) => LicensePage(
        applicationName: applicationName,
        applicationVersion: applicationVersion,
        applicationIcon: applicationIcon,
        applicationLegalese: applicationLegalese,
      ),
    ));
  }
}
