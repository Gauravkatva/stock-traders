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
}
