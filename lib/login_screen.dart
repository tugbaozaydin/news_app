import 'dart:async';

import 'package:flutter/material.dart';

import 'constants.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  int _state = 0;
  int _stateGoogle=0;
  Animation _animation;
  AnimationController _controller;
  GlobalKey _globalKey = GlobalKey();
  GlobalKey _globalGoogleKey = GlobalKey();

  double _width = double.maxFinite;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/splash.jpg"),
                  SizedBox(height: 10.0),
                  usernameField(),
                  SizedBox(height: 10.0),
                  passwordField(),
                  SizedBox(height: 15.0),
                  progressButton(_globalKey,(){
                    setState(() {
                      if (_state == 0) {
                        animateButton(_globalKey,_state);
                      }});
                  },"Giriş Yap",_state),
                  SizedBox(height: 15.0),
                  progressButton(_globalGoogleKey,(){
                    final snackBar = SnackBar(
                      content: Text("Lütfen boşlukları doldurunuz."),
                    );
                    _scaffoldKey.currentState.showSnackBar(snackBar);
                    /*setState(() {
                      if (_stateGoogle == 0) {
                        animateButton(_globalGoogleKey,_stateGoogle);
                      }});*/
                  },"Google ile Giriş Yap",_stateGoogle),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextField usernameField() {
    return TextField(
      autocorrect: false,
      enableSuggestions: false,
      keyboardType: TextInputType.emailAddress,
      obscureText: false,
      controller: usernameController,
      decoration: inputDecoration("Email"),
    );
  }

  TextField passwordField() {
    return TextField(
      controller: passwordController,
      obscureText: true,
      decoration: inputDecoration("Parola"),
    );
  }

  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        labelText: labelText,
        border: OutlineInputBorder());
  }

  PhysicalModel progressButton(GlobalKey globalKey,GestureTapCallback onTap,String text,int state) {
    return PhysicalModel(
      elevation: 8,
      shadowColor: kPrimaryColor,
      color: kPrimaryColor,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        key: globalKey,
        height: 48,
        width: _width,
        child: RaisedButton(
          animationDuration: Duration(milliseconds: 1000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          padding: EdgeInsets.all(0),
          child: setUpButtonChild(text,state),
          onPressed: () {
            onTap();
            /* if (usernameController.text.isEmpty &&
                passwordController.text.isEmpty) {
              final snackBar = SnackBar(
                content: Text("Lütfen boşlukları doldurunuz."),
              );
              _scaffoldKey.currentState.showSnackBar(snackBar);
            }
            else {
                if (response.statusCode == 201) {
                  setState(() {
                    if (_state == 0) {
                      animateButton();
                    }
                  });
                } else {
                  final snackBar = SnackBar(
                    content: Text("Giriş Bilgileri Hatalı."),
                  );
                  _scaffoldKey.currentState.showSnackBar(snackBar);
                }
            }*/
          },
          elevation: 4,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  setUpButtonChild(String text,int state) {
    if (state == 0) {
      return Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      );
    } else if (state == 1) {
      return SizedBox(
        height: 36,
        width: 36,
        child: CircularProgressIndicator(
          value: null,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
      //widget olması

    }
  }

  void animateButton(GlobalKey globalKey,int state) {
    double initialWidth = globalKey.currentContext.size.width;

    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    _animation = Tween(begin: 0.0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - 48) * _animation.value);
        });
      });
    _controller.forward();

    setState(() {
      state = 1;
    });

    Timer(Duration(milliseconds: 3300), () {
      setState(() {
        state = 2;
        Timer(Duration(milliseconds: 10), () {
          /*  Navigator.pushNamedAndRemoveUntil(
              context, DashboardScreen.routeName, ModalRoute.withName('/'),
              arguments: {});*/
        });
      });
    });
  }


}
