import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shopify_app/models/category.model.dart';
import 'package:shopify_app/models/product.model.dart';

class DataSeeder {
  static Map _data = {};

  static List<Product> products = [];
  static List<CategoryData> categories = [];

  static Future<void> loadData() async {
    await Future.delayed(const Duration(seconds: 5));
    var response = await rootBundle.loadString('assets/data/data.json');
    _data = jsonDecode(response);
    products =
        (_data['products'] as List).map((e) => Product.fromJson(e)).toList();

    categories = (_data['categories'] as List)
        .map((e) => CategoryData.fromJson(e))
        .toList();
  }
}
