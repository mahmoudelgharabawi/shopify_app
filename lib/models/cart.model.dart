class Cart {
  List<CartItem>? items;

  Cart();

  Cart.fromJson(Map<String, dynamic> data) {
    items = data['items'] != null
        ? List.from(data['items'].map((e) => CartItem.fromJson(e)))
        : null;
  }

  Map<String, dynamic> toJson() => {
        "items": items?.map((e) => e.toJson()),
      };
}

class CartItem {
  String? itemId;
  Map<String, dynamic>? selectedVarints;
  String? productId;
  int? quantity;

  CartItem();

  CartItem.fromJson(Map<String, dynamic> data) {
    itemId = data['itemId'];
    productId = data['productId'];
    quantity = data['quantity'];
    selectedVarints = data['selectedVarints'] != null
        ? Map<String, dynamic>.from(data['selectedVarints'])
        : null;
  }

  Map<String, dynamic> toJson() => {
        "itemId": itemId,
        "selectedVarints": selectedVarints,
        "productId": productId,
        "quantity": quantity,
      };
}
