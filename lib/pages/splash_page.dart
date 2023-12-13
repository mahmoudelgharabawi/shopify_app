import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopify_app/pages/home_page.dart';
import 'package:shopify_app/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    checkUser();
    super.initState();
  }

  void checkUser() async {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginPage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator()],
        ),
      ),
    );
  }
}
