import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Stock {
  Stock({
    this.documentId,
    this.cmp,
    this.createdBy,
    this.exchange,
    this.sl,
    this.symbol,
    this.target1,
    this.target2,
    this.target3,
    this.tradeStatus,
    this.createdAt,
    this.triggeredAt,
  });
  final String? documentId;
  final double? cmp;
  final Timestamp? createdAt;
  final String? createdBy;
  final String? exchange;
  final double? sl;
  final String? symbol;
  final double? target1;
  final double? target2;
  final double? target3;
  final String? tradeStatus;
  final Timestamp? triggeredAt;

  factory Stock.fromJson(json) => _$StockFromJson(json);
  toJson() => _$StockToJson(this);
}
