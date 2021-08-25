import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stock_traders/screens/add_stock_form/models/stock_model.dart';

class StockService {
  CollectionReference _firestoreCollectionReference =
      FirebaseFirestore.instance.collection("trades");

  Stream<List<Stock>> getStocks() {
    return _firestoreCollectionReference.snapshots().map(
        (event) => event.docs.map((e) => Stock.fromJson(e.data())).toList());
  }

  Future<void> hitTarget(Timestamp time, String documentId) async {
    try {
      await _firestoreCollectionReference.doc(documentId).update({
        "tradeStatus": "SUCCESS",
        "triggeredAt": time,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> hitStopLoss(Timestamp time, String documentId) async {
    try {
      await _firestoreCollectionReference.doc(documentId).update({
        "tradeStatus": "FAILURE",
        "triggeredAt": time,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteStock(String documentId) async {
    try {
      await _firestoreCollectionReference.doc(documentId).delete();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addStock(
      String exchange,
      String symbol,
      double currentMarketPrice,
      double stopLoss,
      double target1,
      double target2,
      double target3) async {
    try {
      await _firestoreCollectionReference.add({
        'cmp': currentMarketPrice,
        'createdAt': Timestamp.now(),
        'createdBy': FirebaseAuth.instance.currentUser?.uid,
        'exchange': exchange,
        'sl': stopLoss,
        'symbol': symbol,
        'target1': target1,
        'target2': target2,
        'target3': target3,
        'tradeStatus': "ONGOING",
        'triggeredAt': null,
      }).then((value) => value.update({'documentId': value.id}));
    } catch (e) {
      throw Exception(e);
    }
  }
}
