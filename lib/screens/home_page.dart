import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_traders/app.dart';
import 'package:stock_traders/authentication/services/auth.dart';
import 'package:stock_traders/screens/add_stock_form/models/stock_model.dart';
import 'package:stock_traders/screens/add_stock_form/view/add_stock_form.dart';
import 'package:stock_traders/screens/stock_page.dart';
import 'package:stock_traders/utils/app_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Auth _auth = Auth();
  Color? _tileColor(String value) {
    Color? color = Colors.white;
    if (value.toUpperCase() == "SUCCESS") {
      color = Colors.green[200];
    } else if (value.toUpperCase() == "FAILURE") {
      color = Colors.red[200];
    } else if (value.toUpperCase() == "ONGOING") {
      color = Colors.yellow[200];
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    List _stockList = Provider.of<List<Stock>>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "Stock Traders",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          Stock stock = _stockList[index];
          return Container(
            margin: EdgeInsets.only(bottom: 4),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${stock.symbol}",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.black),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "CMP: ${stock.cmp}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        "Stop Loss: ${stock.sl}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Text(
                "Status: ${stock.tradeStatus}",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.black),
              ),
              onTap: () {
                pushScreen(StockPage(stock: stock), context);
              },
              tileColor: _tileColor(stock.tradeStatus!),
            ),
          );
        },
        itemCount: _stockList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pushScreen(AddStockForm(), context);
        },
        child: Icon(Icons.add),
        tooltip: "Add Stocks",
      ),
    );
  }
}
