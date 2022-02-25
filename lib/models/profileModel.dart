import 'package:firebase_auth/firebase_auth.dart';

class ProfileModel{
  static late var userCredential;
  static late var  id;
  String name;
  String surname;
  String number;
  String avatarPatch;

  ProfileModel({required this.name, required this.surname,required this.number, required this.avatarPatch});

  static void unset(){
    userCredential = null;
    id = null;
  }
}