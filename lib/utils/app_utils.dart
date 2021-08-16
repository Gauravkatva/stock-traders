import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void pushScreen(Widget screen, BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
}

void pushReplaceScreen(Widget screen, BuildContext context) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => screen));
}

void showSnakBar(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

double toDouble(String value) {
  return double.parse(value);
}
