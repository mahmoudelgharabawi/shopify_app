import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shopify_app/models/cart.model.dart';

class CartProvider {
  CartItem? cartItem;

  void createItemInstance() {
    cartItem = CartItem();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> get cartStream =>
      FirebaseFirestore.instance
          .collection('carts')
          .doc(FirebaseAuth.instance.currentUser?.email ?? '')
          .snapshots();

  void onAddItemToCart({required BuildContext context}) async {
    try {
      bool isAllEqual = false;
      int keyCounter = 0;
      String? updatedItemId;
      QuickAlert.show(context: context, type: QuickAlertType.loading);

      var result = await FirebaseFirestore.instance
          .collection('carts')
          .doc(FirebaseAuth.instance.currentUser?.email ?? '')
          .get();

      if (result.exists) {
        var fireBaseCartItem = Cart.fromJson(result.data() ?? {});
        for (var item in fireBaseCartItem.items ?? []) {
          if (cartItem?.productId != item.productId) break;
          if (cartItem?.selectedVarints?.length !=
              item.selectedVarints?.length) {
            break;
          }

          isAllEqual = false;
          keyCounter = 0;

          for (var key in cartItem?.selectedVarints?.keys.toList() ?? []) {
            if (cartItem?.selectedVarints?[key] ==
                item?.selectedVarints?[key]) {
              keyCounter++;
            }
          }

          if (keyCounter == cartItem?.selectedVarints?.length) {
            isAllEqual = true;
            updatedItemId = item?.itemId;
            break;
          } else {
            isAllEqual = false;
          }
        }

        if (isAllEqual && updatedItemId != null) {
          var updatedtItem = fireBaseCartItem.items
              ?.firstWhere((element) => element.itemId == updatedItemId);

          fireBaseCartItem.items
              ?.removeWhere((element) => element.itemId == updatedItemId);

          updatedtItem?.quantity =
              (updatedtItem.quantity ?? 0) + (cartItem?.quantity ?? 0);

          fireBaseCartItem.items?.add(updatedtItem!);

          await FirebaseFirestore.instance
              .collection('carts')
              .doc(FirebaseAuth.instance.currentUser?.email ?? '')
              .update(fireBaseCartItem.toJson());
        } else {
          await FirebaseFirestore.instance
              .collection('carts')
              .doc(FirebaseAuth.instance.currentUser?.email ?? '')
              .update({
            'items': FieldValue.arrayUnion([cartItem?.toJson()])
          });
        }
      } else {
        await FirebaseFirestore.instance
            .collection('carts')
            .doc(FirebaseAuth.instance.currentUser?.email ?? '')
            .set({
          'items': [cartItem?.toJson()]
        });
      }
      if (context.mounted) {
        Navigator.pop(context);
        await QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: 'product Added Successfully')
            .then((value) => Navigator.pop(context));
      }
    } catch (e) {
      if (!context.mounted) return null;
      await QuickAlert.show(
          context: context, type: QuickAlertType.error, title: e.toString());
      return null;
    }
  }
}
