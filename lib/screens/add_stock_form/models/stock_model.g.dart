// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stock _$StockFromJson(Map<String, dynamic> json) {
  return Stock(
    documentId: json['documentId'] as String?,
    cmp: (json['cmp'] as num?)?.toDouble(),
    createdAt: json['createdAt'] == null ? null : json['createdAt'],
    createdBy: json['createdBy'] as String?,
    exchange: json['exchange'] as String?,
    sl: (json['sl'] as num?)?.toDouble(),
    symbol: json['symbol'] as String?,
    target1: (json['target1'] as num?)?.toDouble(),
    target2: (json['target2'] as num?)?.toDouble(),
    target3: (json['target3'] as num?)?.toDouble(),
    tradeStatus: json['tradeStatus'] as String?,
    triggeredAt: json['triggeredAt'] == null ? null : json['triggeredAt'],
  );
}

Map<String, dynamic> _$StockToJson(Stock instance) => <String, dynamic>{
      'documentId': instance.documentId,
      'cmp': instance.cmp,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
      'exchange': instance.exchange,
      'sl': instance.sl,
      'symbol': instance.symbol,
      'target1': instance.target1,
      'target2': instance.target2,
      'target3': instance.target3,
      'tradeStatus': instance.tradeStatus,
      'triggeredAt': instance.triggeredAt,
    };
