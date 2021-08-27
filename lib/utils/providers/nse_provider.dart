import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:stock_traders/screens/add_stock_form/models/nse/nse.dart';

class NSEProvider with ChangeNotifier {
  List<NSE> list = [];
  List<NSE> filteredList = [];
  Future<void> getAllNSEData() async {
    List jsonData = jsonDecode(await rootBundle.loadString('assets/nse.json'));
    list = jsonData.map((e) => NSE.fromJson(e)).toList();
  }
}
