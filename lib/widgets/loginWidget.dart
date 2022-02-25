import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sendmoney/models/profileModel.dart';

import '../functions.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  final _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    String login = '';
    String password = '';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: const Text('Авторизация', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius:  BorderRadius.all(Radius.circular(20))
                        ),
                        hintText: 'Логин',
                        hintStyle: TextStyle(color: Colors.grey,)
                    ),
                    onSaved: (value){
                      login = value.toString();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius:  BorderRadius.all(Radius.circular(20))
                        ),
                        hintText: 'Пароль',
                        hintStyle: TextStyle(color: Colors.grey,)
                    ),
                    onSaved: (value){
                      password = value.toString();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      onPressed: () async {
                        _formKey.currentState!.save();
                        try{
                          UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: login,
                            password: password,
                          );
                          ProfileModel.userCredential = userCredential;
                          ProfileModel.id  = userCredential.user!.uid;
                          print('print-> ${ProfileModel.id}');
                          Navigator.pushNamedAndRemoveUntil(context, '/userPanel', (route) => false);
                        }catch (e){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                content: Text('Неправильный логин или пароль !', textAlign: TextAlign.center,),
                                actions: [
                                  Center(child: TextButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: const Text('Закрыть')))
                                ],
                              )
                          );
                        }
                      },
                      child: const Text('Войти', style: TextStyle(color: Colors.black)),
                      ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


}
