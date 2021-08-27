import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_traders/app.dart';
import 'package:stock_traders/utils/providers/nse_provider.dart';
import 'package:stock_traders/utils/providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<NSEProvider>(
          create: (context) => NSEProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
      ],
      child: App(),
    ),
  );
  // runApp(
  //   ChangeNotifierProvider<NSEProvider>(
  //     create: (_) => NSEProvider(),
  //     child: App(),
  //   ),
  // );
}
