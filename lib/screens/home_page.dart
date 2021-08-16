import 'package:flutter/material.dart';
import 'package:stock_traders/app.dart';
import 'package:stock_traders/authentication/services/auth.dart';
import 'package:stock_traders/utils/app_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Auth _auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Traders"),
        actions: [
          TextButton(
            onPressed: () async {
              try {
                _auth.signOut();
                showSnakBar(context, "User Signed Out!");
                pushReplaceScreen(App(), context);
              } catch (e) {
                showSnakBar(context, e.toString());
              }
            },
            child: Text(
              "Sign Out",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        tooltip: "Add Stocks",
      ),
    );
  }
}
