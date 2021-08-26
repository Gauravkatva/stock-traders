import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
part 'nse.g.dart';

@JsonSerializable()
class NSE {
  final String? symbol;
  final String? name;

  NSE({
    this.symbol,
    this.name,
  });

  factory NSE.fromJson(json) => _$NSEFromJson(json);
  toJson() => _$NSEToJson(this);

  static Future<List<NSE>> getNSEData(String pattern) async {
    List<NSE> list = [];
    List jsonData = jsonDecode(await rootBundle.loadString('assets/nse.json'));
    for (int i = 0; i < jsonData.length; i++) {
      if (jsonData[i]['symbol']
              .toString()
              .toLowerCase()
              .contains(pattern.toLowerCase()) ||
          jsonData[i]['name']
              .toString()
              .toLowerCase()
              .contains(pattern.toLowerCase())) {
        list.add(NSE.fromJson(jsonData[i]));
      }
    }
    return list;
  }

  static getNameFromSymbol(String symbol) async {
    String result = "";
    List jsonData = jsonDecode(await rootBundle.loadString('assets/nse.json'));
    for (int i = 0; i < jsonData.length; i++) {
      if (jsonData[i]['symbol'].toString() == symbol) {
        result = jsonData[i]['name'].toString();
        break;
      } else {
        result = "Not Found :(";
      }
    }
    return result;
  }
}
