import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromRGBO(255, 165, 0, 1);
InputDecoration inputDecoration(String labelText) {
  return InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      labelText: labelText,
      border: OutlineInputBorder());
}