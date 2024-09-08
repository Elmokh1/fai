import 'package:firebase_auth/firebase_auth.dart';

class EngModel {
  // data class
  static const String collectionName = 'users';
  String? id;
  String? name;
  String? email;

  EngModel({this.id, this.name, this.email});

  EngModel.fromFireStore(Map<String, dynamic>? data)
      : this(id: data?['id'], name: data?['name'], email: data?['email']);

  Map<String, dynamic> toFireStore() {
    return {'id': id, 'name': name, 'email': email};
  }
}
