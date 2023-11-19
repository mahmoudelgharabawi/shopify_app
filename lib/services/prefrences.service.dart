import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefrencesService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    try {
      debugPrint(
          '=============================init Prefrences ===================================');
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print('>>> error in config prefrences ${e.toString()}');
    }
  }

  static SharedPreferences? get prefs => _prefs;
}
