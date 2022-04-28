import 'package:food_delivery/data/models/products_model.dart';

class CartModel {
  int? id;
  String? name;

  int? price;

  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  ProductModel? product;

  CartModel({
    this.id,
    this.name,
    this.price,
    this.img,
    this.quantity,
    this.isExist,
    this.time,
    this.product,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    isExist = json['isExist'];
    time = json['time'];
    img = json['img'];
    product = ProductModel.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'isExist': isExist,
      'time': time,
      'img': img,
      'product':product!.toJson(),
    };
  }
}
