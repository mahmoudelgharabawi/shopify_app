import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopify_app/pages/auth/login_page.dart';
import 'package:shopify_app/pages/auth/signup.page.dart';
import 'package:shopify_app/pages/master_page.dart';

class AppAuthProvider extends ChangeNotifier {
  GlobalKey<FormState>? formKey;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  bool obscureText = true;

  void init() async {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void providerDispose() {
    emailController = null;
    passwordController = null;
    formKey = null;
  }

  void toggleObscure() {
    obscureText = !obscureText;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    if ((formKey?.currentState?.validate() ?? false)) {
      try {
        QuickAlert.show(context: context, type: QuickAlertType.loading);
        var credintials = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController?.text ?? '',
                password: passwordController?.text ?? '');
        if (context.mounted) {
          Navigator.pop(context);
          if (credintials.user != null) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const MasterPage()));
            providerDispose();
          } else {
            await QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Error In Signup');
          }
        }
      } on FirebaseAuthException catch (e) {
        if (!context.mounted) return;
        Navigator.pop(context);

        if (e.code == 'user-not-found') {
          await QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'user not found');
        } else if (e.code == 'wrong-password') {
          await QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'wrong password');
        } else {
          await QuickAlert.show(
              context: context, type: QuickAlertType.error, title: e.code);
        }
      } catch (e) {
        if (!context.mounted) return;
        Navigator.pop(context);

        await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Login Error ${e}');
      }
    }
  }

  Future<void> signUp(BuildContext context) async {
    if ((formKey?.currentState?.validate() ?? false)) {
      try {
        QuickAlert.show(context: context, type: QuickAlertType.loading);

        var credintials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController?.text ?? '',
                password: passwordController?.text ?? '');

        if (context.mounted) {
          Navigator.pop(context);
          if (credintials.user != null) {
            await QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: 'You Signup Successfully');

            if (context.mounted) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const MasterPage()));
              providerDispose();
            }
          } else {
            await QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Error In Signup');
          }
        }
      } on FirebaseAuthException catch (e) {
        if (!context.mounted) return;
        Navigator.pop(context);
        if (e.code == 'email-already-in-use') {
          await QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'This Email Already in use');
        } else if (e.code == 'weak-password') {
          await QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Weak Password');
        }
      } catch (e) {
        if (!context.mounted) return;
        Navigator.pop(context);

        await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Signup Error ${e}');
      }
    }
  }

  Future<void> onLogout(BuildContext contextEx) async {
    QuickAlert.show(context: contextEx, type: QuickAlertType.loading);

    await Future.delayed(const Duration(milliseconds: 300));

    await FirebaseAuth.instance.signOut();
    await GetIt.I.get<SharedPreferences>().clear();
    Navigator.pop(contextEx);
    Navigator.pushReplacement(
        contextEx, MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  void openSignupPage(BuildContext context) {
    providerDispose();
    if (context.mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const SignupPage()));
    }
  }
}
