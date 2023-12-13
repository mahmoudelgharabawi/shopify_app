import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopify_app/pages/master_page.dart';

class AppAuthProvider extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool obscureText = true;

  void init() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void providerDispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  void toggleObscure() {
    obscureText = !obscureText;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    if ((formKey.currentState?.validate() ?? false)) {
      try {
        var credintials = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        if (credintials.user != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const MasterPage()));
        } else {}
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
        } else if (e.code == 'wrong-password') {}
      } catch (e) {}
    }
  }

  Future<void> signUp(BuildContext context) async {
    if ((formKey.currentState?.validate() ?? false)) {
      try {
        var credintials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        if (credintials.user != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const MasterPage()));
        } else {}
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
        } else if (e.code == 'weak-password') {}
      } catch (e) {}
    }
  }
}
