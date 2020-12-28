import 'package:flutter/material.dart';

import 'package:news_app/search_notifier.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

class CategoriButton extends StatefulWidget {
  const CategoriButton({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;

  @override
  _CategoriButtonState createState() => _CategoriButtonState();
}

class _CategoriButtonState extends State<CategoriButton> {
  @override
  Widget build(BuildContext context) {
    var _listProvider = Provider.of<SearchNotifier>(context);

    bool press =false;
    return Padding(
      padding:
          const EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: press ? kPrimaryColor : Colors.white,
        onPressed: () {
          setState(() => press = !press);
        } ,
        child: Text(
          widget.title,
        ),
      ),
    );
  }
}
