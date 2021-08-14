import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stock_traders/app.dart';

void main() {
  runApp(App());
  Firebase.initializeApp();
}
