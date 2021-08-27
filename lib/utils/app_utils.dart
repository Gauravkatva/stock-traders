import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_traders/screens/add_stock_form/models/nse/nse.dart';

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

String getName(String symbol, List<NSE> list) {
  String result = "Not Found :(";
  for (int i = 0; i < list.length; i++) {
    if (list[i].symbol!.toLowerCase() == symbol.toLowerCase()) {
      result = list[i].name!;
      break;
    }
  }
  return result;
}
