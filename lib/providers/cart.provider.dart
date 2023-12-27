import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shopify_app/models/cart.model.dart';

import '../models/product.model.dart';

class CartProvider {
  CartItem? cartItem;
  List<Product> products = [];

  double _total = 0;

  ValueNotifier<double> totalNotifier = ValueNotifier(0);

  void onAddProductToProductsList(Product product, Cart cart) {
    var index = products.indexWhere((element) => (element.id == product.id));

    // Todo Check Avaliable Quantity In Product

    if (index == -1) {
      products.add(product);
    }
  }

  void initCalculateTotal() {}

  void calculateTotal(Cart cart) {
    _total = 0;
    for (var item in cart.items!) {
      if (products.isEmpty) return;
      var product =
          products.firstWhere((product) => product.id == item.productId);
      _total += (product.price ?? 0) * (item.quantity ?? 0);
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      totalNotifier.value = _total;
    });
  }

  void createItemInstance() {
    cartItem = CartItem();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> get cartStream =>
      FirebaseFirestore.instance
          .collection('carts')
          .doc(FirebaseAuth.instance.currentUser?.email ?? '')
          .snapshots();

  void onRemoveProductFromCart(
      {required BuildContext context,
      required String itemId,
      required Cart cart}) async {
    try {
      var result = await QuickAlert.show(
          context: context,
          type: QuickAlertType.confirm,
          onConfirmBtnTap: () => Navigator.pop(context, true));

      if (result ?? false) {
        if (context.mounted) {
          QuickAlert.show(context: context, type: QuickAlertType.loading);
          cart.items?.removeWhere((element) => element.itemId == itemId);

          await FirebaseFirestore.instance
              .collection('carts')
              .doc(FirebaseAuth.instance.currentUser?.email ?? '')
              .update(cart.toJson());
          if (context.mounted) {
            Navigator.pop(context);
            calculateTotal(cart);
            await QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: 'product Deleted Successfully');
          }
        }
      }
    } catch (e) {
      if (!context.mounted) return;
      await QuickAlert.show(
          context: context, type: QuickAlertType.error, title: e.toString());
    }
  }

  void onIncreaseItemQuantityInCart(
      {required BuildContext context,
      required String itemId,
      required Cart cart}) async {
    try {
      if (context.mounted) {
        QuickAlert.show(context: context, type: QuickAlertType.loading);
        var updatedItem =
            cart.items?.firstWhere((element) => element.itemId == itemId);

        cart.items?.removeWhere((element) => element.itemId == itemId);

        updatedItem!.quantity = (updatedItem.quantity ?? 0) + 1;
        cart.items?.add(updatedItem);

        await FirebaseFirestore.instance
            .collection('carts')
            .doc(FirebaseAuth.instance.currentUser?.email ?? '')
            .update(cart.toJson())
            .then((value) => Navigator.pop(context));
        calculateTotal(cart);
      }
    } catch (e) {
      if (!context.mounted) return;
      await QuickAlert.show(
          context: context, type: QuickAlertType.error, title: e.toString());
    }
  }

  void onDecreaseItemQuantityInCart(
      {required BuildContext context,
      required String itemId,
      required Cart cart}) async {
    try {
      if (context.mounted) {
        var updatedItem =
            cart.items?.firstWhere((element) => element.itemId == itemId);
        if (updatedItem?.quantity == 1) {
          onRemoveProductFromCart(context: context, itemId: itemId, cart: cart);

          return;
        }

        QuickAlert.show(context: context, type: QuickAlertType.loading);

        cart.items?.removeWhere((element) => element.itemId == itemId);

        updatedItem!.quantity = (updatedItem.quantity ?? 0) - 1;
        cart.items?.add(updatedItem);

        await FirebaseFirestore.instance
            .collection('carts')
            .doc(FirebaseAuth.instance.currentUser?.email ?? '')
            .update(cart.toJson())
            .then((value) => Navigator.pop(context));
        calculateTotal(cart);
      }
    } catch (e) {
      if (!context.mounted) return;
      await QuickAlert.show(
          context: context, type: QuickAlertType.error, title: e.toString());
    }
  }

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
