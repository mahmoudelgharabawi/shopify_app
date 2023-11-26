import 'package:flutter/material.dart';
import 'package:shopify_app/pages/master_page.dart';
import 'package:shopify_app/pages/login_page.dart';
import 'package:shopify_app/pages/splash_page.dart';
import 'package:shopify_app/services/prefrences.service.dart';
import 'package:shopify_app/utils/theme.utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrefrencesService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopify Application',
      theme: ThemeUtils.themeData,
      home: SplashPage(),
    );
  }
}
