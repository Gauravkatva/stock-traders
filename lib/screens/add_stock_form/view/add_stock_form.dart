import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:stock_traders/screens/add_stock_form/models/nse/nse.dart';
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
    try {
      return double.parse(value);
    } catch (e) {
      return 0.0;
    }
  }

  final StockService _stockService = StockService();

  double calculatePercentage(double value) {
    try {
      double cmp = toDouble(currentMarketPriceController.text);
      return ((value - cmp) / cmp) * 100;
    } catch (e) {
      return 0;
    }
  }

  void _onFieldChanged(String value) {
    setState(() {});
  }

  Widget textField({
    TextEditingController? controller,
    Function(String)? onChanged,
    String? labelText,
    bool showSuffixPercentage = false,
    bool restrictSpecialChar = true,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    Icon prefixIcon = const Icon(Icons.attach_money_sharp),
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        enableInteractiveSelection: false,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: labelText,
          border: OutlineInputBorder(),
          suffixText: showSuffixPercentage
              ? (controller!.text.isEmpty
                  ? "0.0 %"
                  : "${calculatePercentage(toDouble(controller.text)).toStringAsFixed(2)}%")
              : null,
        ),
        inputFormatters: restrictSpecialChar
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.deny(RegExp("[-, , ,]")),
              ]
            : null,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
      ),
    );
  }

  late List<NSE> list;

  void init() async {
    list = await NSE.getNSEData("");
  }

  @override
  void initState() {
    init();
    super.initState();
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
                },
              ),
              // textField(
              //   controller: symbolController,
              //   labelText: "Symbol *",
              //   textInputAction: TextInputAction.next,
              //   prefixIcon: Icon(Icons.auto_graph),
              //   restrictSpecialChar: false,
              // ),
              TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: symbolController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Symbol *",
                    prefixIcon: Icon(Icons.auto_graph),
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  return await NSE.getNSEData(pattern);
                },
                errorBuilder: (context, error) {
                  return Text("No Data found with this Name :(");
                },
                itemBuilder: (context, NSE suggestion) {
                  return ListTile(
                    leading: Icon(Icons.auto_graph),
                    title: Text(suggestion.symbol!),
                    subtitle: Text(suggestion.name!),
                  );
                },
                onSuggestionSelected: (NSE suggestion) {
                  symbolController.text = suggestion.symbol!;
                },
              ),
              textField(
                controller: currentMarketPriceController,
                onChanged: _onFieldChanged,
                labelText: "Current Market Price *",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
              textField(
                controller: stopLossController,
                onChanged: _onFieldChanged,
                labelText: "Stop Loss *",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                showSuffixPercentage: true,
              ),
              textField(
                controller: target1Controller,
                onChanged: _onFieldChanged,
                labelText: "Target 1 *",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                showSuffixPercentage: true,
              ),
              textField(
                controller: target2Controller,
                onChanged: _onFieldChanged,
                labelText: "Target 2",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                showSuffixPercentage: true,
              ),
              textField(
                controller: target3Controller,
                onChanged: _onFieldChanged,
                labelText: "Target 3",
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                showSuffixPercentage: true,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: !pressed
                      ? () async {
                          if (symbolController.text.isNotEmpty &&
                              currentMarketPriceController.text.isNotEmpty &&
                              stopLossController.text.isNotEmpty &&
                              target1Controller.text.isNotEmpty) {
                            try {
                              setState(() {
                                pressed = true;
                              });
                              await _stockService.addStock(
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
                            showSnakBar(context, "Fields with * are mandetory");
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
