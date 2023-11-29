class Product {
  String? id;
  String? categoryId;
  String? description;
  String? name;
  double? price;
  int? quantity;

  Product();

  Product.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    categoryId = data['categoryId'];
    description = data['description'];
    name = data['name'];
    price = data['price'];
    quantity = data['quantity'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "categoryId": categoryId,
      "description": description,
      "name": name,
      "price": price,
      "quantity": quantity,
    };
  }
}
