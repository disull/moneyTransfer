import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sendmoney/functions.dart';
import 'package:sendmoney/models/profileModel.dart';

class Profile extends StatelessWidget {

   Profile(
      {Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    List profiles = getProfiles();
    int idProfile = 1;


    var maskFormatter = MaskTextInputFormatter(
        mask: '+7 ### ### ## ##',
        filter: { "#": RegExp(r'[0-9]') },
        type: MaskAutoCompletionType.lazy
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        shadowColor: Colors.black.withOpacity(0),
        title: Text('Профиль', style: Theme.of(context).textTheme.headline2),
        centerTitle: true,
      ),
      body:
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector( /*todo: Сделать изменение фотографии по клику*/
                          child:  Center(
                            child: CircleAvatar(
                              backgroundImage: AssetImage(profiles[idProfile].avatarPatch),
                              radius: 70,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: TextEditingController(text: profiles[idProfile].name),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:  BorderRadius.all(Radius.circular(20))
                            ),
                          hintText: 'Имя',
                          hintStyle: TextStyle(color: Colors.grey,)
                        ),
                        validator: (value){
                          if(value==null|| value.isEmpty){
                            return 'Введите имя';
                          }
                        },
                        onSaved: (value){
                          setUserName(idProfile, value!);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: TextEditingController(text: profiles[idProfile].surname),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:  BorderRadius.all(Radius.circular(20))
                            ),
                            hintText: 'Фамилия',
                            hintStyle: TextStyle(color: Colors.grey,)
                        ),
                        validator: (value){
                          if(value==null|| value.isEmpty){
                            return 'Введите Фамилию';
                          }
                        },
                        onSaved: (value){
                          setUserSurname(idProfile, value!);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        inputFormatters: [maskFormatter],
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        controller: TextEditingController(text: profiles[idProfile].number),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:  BorderRadius.all(Radius.circular(20))
                            ),
                            hintText: '+7 000 000 00 00',
                            hintStyle: TextStyle(color: Colors.grey,)
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Введите номер телефона';
                          }
                        },
                        onSaved: (value){
                          setUserNumber(idProfile, value!);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white
                            ),
                            child: const Text('Сохранить',style: TextStyle(color: Colors.black),),
                          onPressed: (){
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                                print('Ok');
                              }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white
                          ),
                          child: const Text('Выпустить карту',style: TextStyle(color: Colors.black),),
                          onPressed: (){
                            showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              content: Text('Функция в разработке', textAlign: TextAlign.center,),
                              actions: [
                                Center(child: TextButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: const Text('Cancel')))
                              ],
                              )
                            );
                          }
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red.shade400
                            ),
                            child: const Text('Выйти',style: TextStyle(color: Colors.black),),
                            onPressed: (){
                              signOut();
                              Navigator.pushNamedAndRemoveUntil(context, '/loginPage', (route) => false);
                            }
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
