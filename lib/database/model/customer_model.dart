import 'package:firebase_auth/firebase_auth.dart';

class CustomerModel {
  // data class
  static const String collectionName = 'User';
  String? id;
  String? name;
  String? email;
  String? token;
  bool? isCustomer;
  bool? isAdmin;
  bool? isFarmer;
  bool? isEng;
  bool? isUpperEgypt;
  String? engId;
  String? engName;

  CustomerModel({
    this.id,
    this.name,
    this.email,
    this.token,
    this.isCustomer,
    this.isFarmer,
    this.engId = "",
    this.engName= "",
    this.isEng,
    this.isAdmin,
    this.isUpperEgypt,
  });

  CustomerModel.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data?['id'],
          name: data?['name'],
          email: data?['email'],
          token: data?['token'],
          isCustomer: data?['isCustomer'],
          isFarmer: data?['isFarmer'],
    isUpperEgypt: data?['isUpperEgypt'],
          isEng: data?['isEng'],
          isAdmin: data?['isAdmin'],
          engName: data?['engName'],
          engId: data?['engId'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'isFarmer': isFarmer,
      'isUpperEgypt': isUpperEgypt,
      'isCustomer': isCustomer,
      'engName': engName,
      'engId': engId,
      'isEng': isEng,
      'isAdmin': isAdmin,
    };
  }
}
