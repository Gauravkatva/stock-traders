import 'package:flutter/material.dart';
import 'package:stock_traders/authentication/services/auth.dart';
import 'package:stock_traders/screens/home_page.dart';
import 'package:stock_traders/screens/splash_screen.dart';
import 'authentication/login/view/login_page.dart';

enum AppState { splash, home, logIn }

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  AppState state = AppState.splash;
  final Auth _auth = Auth();

  void _stateChange() async {
    await Future.delayed(Duration(seconds: 2));
    bool isSignedIn = await _auth.isSignedIn();
    if (isSignedIn) {
      setState(() {
        state = AppState.home;
      });
    } else {
      setState(() {
        state = AppState.logIn;
      });
    }
  }

  @override
  void initState() {
    _stateChange();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: _buildForState(),
    );
  }

  Widget _buildForState() {
    switch (state) {
      case AppState.splash:
        return SplashScreen();
      case AppState.logIn:
        return LoginPage();
      case AppState.home:
        return HomePage();
      default:
        return SplashScreen();
    }
  }
}
