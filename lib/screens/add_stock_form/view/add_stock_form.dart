import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_traders/screens/add_stock_form/services/add_stock_service.dart';
import 'package:stock_traders/screens/widgets/widgets.dart';
import 'package:stock_traders/utils/app_utils.dart';

class AddStockForm extends StatefulWidget {
  const AddStockForm({Key? key}) : super(key: key);

  @override
  _AddStockFormState createState() => _AddStockFormState();
}

class _AddStockFormState extends State<AddStockForm> {
  String exchange = "NSE";
  late DateTime createdAt;
  bool pressed = false;
  final TextEditingController symbolController = TextEditingController();
  final TextEditingController currentMarketPriceController =
      TextEditingController();
  final TextEditingController stopLossController = TextEditingController();
  final TextEditingController target1Controller = TextEditingController();
  final TextEditingController target2Controller = TextEditingController();
  final TextEditingController target3Controller = TextEditingController();
  double toDouble(String value) {
    return double.parse(value);
  }

  final StockService _stockService = StockService();

  double calculatePercentage(double value) {
    double cmp = toDouble(currentMarketPriceController.text);
    return ((value - cmp) / cmp) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "Add Stock",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              CustomSelector(
                onChanged: (value) {
                  exchange = value;
                  print(value);
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: symbolController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.auto_graph),
                    labelText: "Symbol",
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: currentMarketPriceController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.attach_money_sharp),
                    labelText: "Current Market Price",
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: stopLossController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.attach_money_sharp),
                    labelText: "Stop Loss",
                    border: OutlineInputBorder(),
                    suffixText: stopLossController.text.isEmpty
                        ? "0.0 %"
                        : "${calculatePercentage(toDouble(stopLossController.text)).toStringAsFixed(2)}%",
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: target1Controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.attach_money_sharp),
                    labelText: "Target 1",
                    border: OutlineInputBorder(),
                    suffixText: target1Controller.text.isEmpty
                        ? "0.0 %"
                        : "${calculatePercentage(toDouble(target1Controller.text)).toStringAsFixed(2)}%",
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: target2Controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.attach_money_sharp),
                    labelText: "Target 2",
                    border: OutlineInputBorder(),
                    suffixText: target2Controller.text.isEmpty
                        ? "0.0 %"
                        : "${calculatePercentage(toDouble(target2Controller.text)).toStringAsFixed(2)}%",
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: target3Controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.attach_money_sharp),
                    labelText: "Target 3",
                    border: OutlineInputBorder(),
                    suffixText: target3Controller.text.isEmpty
                        ? "0.0 %"
                        : "${calculatePercentage(toDouble(target3Controller.text)).toStringAsFixed(2)}%",
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: !pressed
                      ? () async {
                          if (symbolController.text.isNotEmpty &&
                              currentMarketPriceController.text.isNotEmpty &&
                              stopLossController.text.isNotEmpty &&
                              target1Controller.text.isNotEmpty &&
                              target2Controller.text.isNotEmpty &&
                              target3Controller.text.isNotEmpty) {
                            try {
                              setState(() {
                                pressed = true;
                              });
                              _stockService.addStock(
                                  exchange,
                                  symbolController.text,
                                  toDouble(currentMarketPriceController.text),
                                  toDouble(stopLossController.text),
                                  toDouble(target1Controller.text),
                                  toDouble(target2Controller.text),
                                  toDouble(target3Controller.text));
                              showSnakBar(context, "Stock Added Successfully!");
                              Navigator.of(context).pop();
                            } catch (e) {
                              showSnakBar(context, e.toString());
                            } finally {
                              setState(() {
                                pressed = false;
                              });
                            }
                          } else {
                            showSnakBar(context, "All fields are mandetory");
                          }
                        }
                      : null,
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
