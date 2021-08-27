import 'package:json_annotation/json_annotation.dart';
import 'package:provider/provider.dart';
import 'package:stock_traders/utils/nse_provider.dart';
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

  static Future<List<NSE>> getNSEData(String pattern, context) async {
    List<NSE> list = Provider.of<NSEProvider>(context, listen: false).list;
    List<NSE> resultList = [];
    for (int i = 0; i < list.length; i++) {
      if (list[i]
              .symbol
              .toString()
              .toLowerCase()
              .contains(pattern.toLowerCase()) ||
          list[i]
              .name
              .toString()
              .toLowerCase()
              .contains(pattern.toLowerCase())) {
        resultList.add(list[i]);
      }
    }
    return resultList;
  }
}
