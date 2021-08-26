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

  static Future<List<NSE>> getNSEData() async {
    List jsonData = jsonDecode(await rootBundle.loadString('assets/nse.json'));
    final List<NSE> list = jsonData.map((e) => NSE.fromJson(e)).toList();
    return list;
  }
}
