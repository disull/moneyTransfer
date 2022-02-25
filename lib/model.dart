import 'package:cloud_firestore/cloud_firestore.dart';

class UserTransaction{
  final int id;
  final String name;
  final double sum;
  String currency;
  Timestamp dataTime;
  //String icon;

  UserTransaction({required this.id, required this.name, required this.sum, required this.currency, required this.dataTime});

  factory UserTransaction.fromJson(Map<String, dynamic> json) {
    return UserTransaction(
      id: json['id'],
      name: json['name'],
      sum: json['sum'],
      currency: json['currency'],
      dataTime: json[DateTime.now().microsecondsSinceEpoch]
    );
  }
}