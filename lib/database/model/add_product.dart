import 'dart:ffi';

class AddProductModel {
  // data class
  static const String collectionName = 'Products';
  String? id;
  String? product;
  int? price;
  String? des;
  String? imageUrl;

  AddProductModel({this.id, this.product, this.price, this.des, this.imageUrl});

  AddProductModel.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data?['id'],
          product: data?['product'],
          price: data?['price'],
          des: data?['des'],
    imageUrl: data?['imageUrl'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'product': product,
      'price': price,
      'des': des,
      'imageUrl': imageUrl,
    };
  }
}
