import 'package:flutter/material.dart';

import 'constants.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({Key key, this.image, this.press, this.text}) : super(key: key);
  final String image;
  final Function press;
  final String text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(
            left: kDefaultPadding,
            right: kDefaultPadding,
            top: kDefaultPadding / 2,
            bottom: kDefaultPadding / 2),
        width: size.width * 0.8,
        height: 185,
        child: text != null ? Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
          ),
        ):Text("Boş"),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image:
                DecorationImage(fit: BoxFit.cover, image: image != null ? NetworkImage(image) : AssetImage("assets/splash.jpg"))),
      ),
    );
  }
}
