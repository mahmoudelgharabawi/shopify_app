import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shopify_app/models/product.model.dart';

class ProductProvider {
  Future<List<Product>?> getProducts(BuildContext context, {int? limit}) async {
    try {
      QuerySnapshot<Map<String, dynamic>>? result;
      if (limit != null) {
        result = await FirebaseFirestore.instance
            .collection('products')
            .limit(limit)
            .get();
      } else {
        result = await FirebaseFirestore.instance.collection('products').get();
      }

      if (result.docs.isNotEmpty) {
        var productsList = List<Product>.from(
            result.docs.map((e) => Product.fromJson(e.data(), e.id))).toList();

        return productsList;
      } else {
        return [];
      }
    } catch (e) {
      if (!context.mounted) return null;
      await QuickAlert.show(
          context: context, type: QuickAlertType.error, title: e.toString());
      return null;
    }
  }

  Future<Product?> getProductById({required String productId}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>>? result;

      result = await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .get();

      if (result.exists) {
        return Product.fromJson(result.data() ?? {}, result.id);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
