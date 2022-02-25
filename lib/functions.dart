import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:sendmoney/dataFiles/dataProfile.dart';
import 'package:sendmoney/model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sendmoney/models/moneyTransfer.dart';
import 'package:sendmoney/models/profileModel.dart';
import 'package:sendmoney/widgets/loginWidget.dart';

Future<List<UserTransaction>> getTransaction() async {
  List<UserTransaction> transactions = [];
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('transactions').where('UID', isEqualTo: ProfileModel.id).get();
  for(var item in snapshot.docs){
    UserTransaction transaction = UserTransaction(
      id: item.get("id"),
      name: item.get("name"),
      currency: item.get("currency"),
      sum: item.get("sum").toDouble(),
      dataTime: item.get('data'),
    );
    transactions.add(transaction);
  }
  return transactions;
}

List getProfiles(){
 return profiles;
}

void setUserName(int idProfile, String value){
  profiles[idProfile].name = value;
}
void setUserSurname(int idProfile, String value){
 profiles[idProfile].surname = value;
}
void setUserNumber(int idProfile, String value){
 profiles[idProfile].number = value;
}

Future getData() async {
  await Firebase.initializeApp();
  var firestore = FirebaseFirestore.instance;
  QuerySnapshot qn = await firestore.collection('transactions').get();
  return qn.docs;
}

Future<Future<DocumentReference<Object?>>> addTransaction(MoneyTransfer moneyTransfer)async {
  CollectionReference transactions = await FirebaseFirestore.instance.collection('transactions');
  return transactions
      .add({
    'UID' : ProfileModel.id,
    'id' : 123,
    'currency' : 'руб',
    'name' : 'Сбербанк',
    'sum' : moneyTransfer.sum,
    'data' : Timestamp.now(),
  });

}
Future<void> signOut() async {
  ProfileModel.unset();
  await FirebaseAuth.instance.signOut();
}


