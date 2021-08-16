import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_traders/screens/widgets/widgets.dart';

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
  final TextEditingController currentMarketPricelController =
      TextEditingController();
  final TextEditingController stopLossController = TextEditingController();
  final TextEditingController target1Controller = TextEditingController();
  final TextEditingController target2Controller = TextEditingController();
  final TextEditingController target3Controller = TextEditingController();
  double toDouble(String value) {
    return double.parse(value);
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
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.auto_graph),
                    hintText: "Symbol",
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.attach_money_sharp),
                    hintText: "Current Market Price",
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.attach_money_sharp),
                    hintText: "Stop Loss",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.attach_money_sharp),
                    hintText: "Target 1",
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.attach_money_sharp),
                    hintText: "Target 2",
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.attach_money_sharp),
                    hintText: "Target 3",
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: !pressed ? () async {} : null,
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
