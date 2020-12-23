
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = "/register";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _success = true;
  String _message;
  int state=0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıt Ol"),
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(

          child: Column(
            children: [
              Image.asset("assets/splash.jpg"),
              SizedBox(height: 10.0),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: inputDecoration("E-Mail"),
                          validator: (String mail) {
                            if (mail.isEmpty) {
                              return "Lütfen bir mail yazın";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),

                        TextFormField(
                          controller: _passwordController,
                          decoration: inputDecoration("Şifre"),
                          validator: (String password) {
                            if (password.isEmpty) {
                              return "Lütfen bir şifre yazın";
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          alignment: Alignment.center,
                          child:
                          RaisedButton(
                            color: kPrimaryColor,
                            child: Center(
                                child: Text(
                                  "Kayıt Ol",
                                  style: TextStyle(color: Colors.white),
                                )),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _register();
                              }
                            },
                          )

                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(_success == null ? '' : _message ?? ''),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() async {
    try {
      final User user = (await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      if (user != null) {
        setState(() {


          _success = true;
          _message = "Kayıt başarılı ${user.email}";
        });
      } else {
        setState(() {
          _success = false;
          _message = "Kayıt başarısız.";
        });
      }
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        _success = false;
        _message = "Kayıt başarısız.\n\n$e";
      });
    }
  }

}
