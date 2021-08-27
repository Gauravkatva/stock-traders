import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_traders/app.dart';
import 'package:stock_traders/utils/nse_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<NSEProvider>(
      create: (_) => NSEProvider(), child: App()));
}
