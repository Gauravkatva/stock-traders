import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_traders/authentication/services/auth.dart';
import 'package:stock_traders/screens/add_stock_form/models/stock_model.dart';
import 'package:stock_traders/screens/add_stock_form/services/add_stock_service.dart';
import 'package:stock_traders/screens/home_page.dart';
import 'package:stock_traders/screens/splash_screen.dart';
import 'package:stock_traders/utils/nse_provider.dart';
import 'authentication/login/view/login_page.dart';

enum AppState { splash, home, logIn }

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  AppState state = AppState.splash;
  final StockService _stockService = StockService();
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
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await Provider.of<NSEProvider>(context, listen: false).getAllNSEData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Stock>>(
      create: (context) => _stockService.getStocks(),
      initialData: [],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: _buildForState(),
      ),
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
