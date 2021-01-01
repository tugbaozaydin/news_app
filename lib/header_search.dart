import 'package:news_app/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

import 'package:news_app/search_notifier.dart';
import 'package:provider/provider.dart';

class HeaderWithSearchBox extends StatelessWidget {
  final Size size;
  final String title;

  const HeaderWithSearchBox({
    Key key,
    this.size,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _listProvider = Provider.of<SearchNotifier>(context);

    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding),
      height: size.height * 0.2,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: kDefaultPadding),
            alignment: Alignment.center,
            height: size.height * 0.2 - 30,
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36))),
            child: Row(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(
                  Icons.title,
                  color: Colors.white,
                )
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 54,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: kPrimaryColor.withOpacity(0.23))
                  ]),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        _listProvider.search(value);
                      },
                      decoration: InputDecoration(
                        hintText: "Arama",
                        hintStyle:
                            TextStyle(color: kPrimaryColor.withOpacity(0.5)),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        // suffixIcon: Icon(Icons.search)
                      ),
                    ),
                  ),
                  Icon(Icons.search)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
