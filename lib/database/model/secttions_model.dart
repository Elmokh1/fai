import 'package:firebase_auth/firebase_auth.dart';

class SectionsModel {
  static const String collectionName = 'sections';
  String? id;
  String? name;

  SectionsModel({
    this.id,
    this.name,
  });

  SectionsModel.fromFireStore(Map<String, dynamic>? data)
      : this(id: data?['id'], name: data?['name']);

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'name': name,
    };
  }
}
