import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_traders/screens/add_stock_form/services/add_stock_service.dart';
import 'package:stock_traders/utils/app_utils.dart';
import 'package:share/share.dart';
import 'add_stock_form/models/stock_model.dart';

class StockPage extends StatefulWidget {
  final Stock stock;
  const StockPage({Key? key, required this.stock}) : super(key: key);

  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  DateTime _triggeringDate = DateTime.now();
  final StockService _stockService = StockService();
  late double currentMarketPrice;
  late String shareMessage;
  double toDouble(String value) {
    try {
      return double.parse(value);
    } catch (e) {
      return 0.0;
    }
  }

  double calculatePercentage(double value) {
    try {
      double cmp = currentMarketPrice;
      return ((value - cmp) / cmp) * 100;
    } catch (e) {
      return 0;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _triggeringDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _triggeringDate)
      setState(() {
        _triggeringDate = picked;
      });
  }

  void init() {
    currentMarketPrice = widget.stock.cmp!;
    shareMessage =
        "${widget.stock.symbol}\nCMP: ${widget.stock.cmp}\nTGT: ${widget.stock.target1}, ${widget.stock.target2}, ${widget.stock.target3}\nSL: ${widget.stock.sl}\n#BREAKOUT #sharing_is_caring #StockMarket #StocksInFocus #StocksToBuy #StocksToWatch";
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profitStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        );
    final lossStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "Stock ${widget.stock.symbol}",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                Share.share(shareMessage);
              },
              icon: Icon(Icons.share)),
          IconButton(
            onPressed: () async {
              try {
                await _stockService.deleteStock(widget.stock.documentId!);
                showSnakBar(context, "Stock Deleted Successfully!!!");
                Navigator.pop(context);
              } catch (e) {
                showSnakBar(context, e.toString());
              }
            },
            icon: Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Created By"),
            subtitle: Text(
              "${widget.stock.createdBy}",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
            ),
          ),
          ListTile(
            title: Text("Created At"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Date: ${widget.stock.createdAt!.toDate().toString().substring(0, 11)}",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                ),
                Text(
                  "Time: ${widget.stock.createdAt!.toDate().toString().substring(11, 16)}",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text("Exchange"),
            subtitle: Text(
              "${widget.stock.exchange}",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
            ),
          ),
          ListTile(
            title: Text("Symbol"),
            subtitle: Text(
              "${widget.stock.symbol}",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
            ),
          ),
          ListTile(
            title: Text("Current Market Price"),
            subtitle: Text(
              "${widget.stock.cmp} INR",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
            ),
          ),
          ListTile(
            title: Text("Stop Loss"),
            subtitle: Text(
              "${widget.stock.sl} INR",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
            ),
            trailing: Text(
              "${calculatePercentage(widget.stock.sl!).toStringAsFixed(2)} %",
              style: calculatePercentage(widget.stock.sl!) >= 0
                  ? profitStyle
                  : lossStyle,
            ),
          ),
          ListTile(
            title: Text("Target 1"),
            subtitle: Text(
              "${widget.stock.target1} INR",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
            ),
            trailing: Text(
              "${calculatePercentage(widget.stock.target1!).toStringAsFixed(2)} %",
              style: calculatePercentage(widget.stock.target1!) >= 0
                  ? profitStyle
                  : lossStyle,
            ),
          ),
          ListTile(
            title: Text("Target 2"),
            subtitle: Text(
              "${widget.stock.target3} INR",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
            ),
            trailing: Text(
              "${calculatePercentage(widget.stock.target2!).toStringAsFixed(2)} %",
              style: calculatePercentage(widget.stock.target2!) >= 0
                  ? profitStyle
                  : lossStyle,
            ),
          ),
          ListTile(
            title: Text("Target 3"),
            subtitle: Text(
              "${widget.stock.target3} INR",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
            ),
            trailing: Text(
              "${calculatePercentage(widget.stock.target3!).toStringAsFixed(2)} %",
              style: calculatePercentage(widget.stock.target3!) >= 0
                  ? profitStyle
                  : lossStyle,
            ),
          ),
          ListTile(
            title: Text("Triigered At"),
            subtitle: Text(
              widget.stock.triggeredAt == null
                  ? "Date: ${_triggeringDate.toString().substring(0, 10)}"
                  : "Date: ${widget.stock.triggeredAt!.toDate().toString().substring(0, 10)}",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
            ),
            trailing: IconButton(
              onPressed: () async {
                if (widget.stock.triggeredAt != null) {
                  showSnakBar(context, "The Stock is already triggered");
                } else {
                  _selectDate(context);
                }
              },
              icon: Icon(Icons.edit),
            ),
          ),
        ],
      ),
      bottomNavigationBar: widget.stock.tradeStatus!.toUpperCase() == "ONGOING"
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                    onPressed: () async {
                      Timestamp time = Timestamp.fromDate(_triggeringDate);
                      try {
                        await _stockService.hitStopLoss(
                            time, widget.stock.documentId!);
                        showSnakBar(context, "Stock Hit Stop Loss!!!");
                        Navigator.pop(context);
                      } catch (e) {
                        showSnakBar(context, e.toString());
                      }
                    },
                    child: Text(
                      "HIT STOP LOSS",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: () async {
                      Timestamp time = Timestamp.fromDate(_triggeringDate);
                      try {
                        await _stockService.hitTarget(
                            time, widget.stock.documentId!);
                        showSnakBar(context, "Stock Hit Target!!!");
                        Navigator.pop(context);
                      } catch (e) {
                        showSnakBar(context, e.toString());
                      }
                    },
                    child: Text(
                      "HIT TARGET",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ],
            )
          : Container(
              height: 50,
              color: widget.stock.tradeStatus!.toUpperCase() == "SUCCESS"
                  ? Colors.green
                  : Colors.redAccent,
              child: Center(
                child: Text(
                  "Status: ${widget.stock.tradeStatus}",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                ),
              ),
            ),
    );
  }
}
