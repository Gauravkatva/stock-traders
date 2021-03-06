import 'package:flutter/material.dart';
import 'authentication/login/view/login_page.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: LoginPage(
        key: Key("login_page"),
      ),
    );
  }
}
