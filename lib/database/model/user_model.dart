import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  // data class
  static const String collectionName = 'users';
  String? id;
  String? name;
  String? email;

  UserModel({this.id, this.name, this.email});

  UserModel.fromFireStore(Map<String, dynamic>? data)
      : this(id: data?['id'], name: data?['name'], email: data?['email']);

  Map<String, dynamic> toFireStore() {
    return {'id': id, 'name': name, 'email': email};
  }
}
