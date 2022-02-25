

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:sendmoney/functions.dart';
import 'package:sendmoney/widgets/cardView.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../models/moneyTransfer.dart';

final moneyFormat = NumberFormat.currency(
  locale: 'ru',
  symbol: '₽',
  decimalDigits: 2,
);





class Transfer extends StatelessWidget {


  final int balance;
  Transfer({
    Key? key,
    required this.balance,
  }) : super(key: key);
  var maskFormatter = MaskTextInputFormatter(
      mask: '#### #### #### ####',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  final _formKey = GlobalKey<FormState>();
  String cardStr = '';
  String summ = '';
  String messageRecipient = '';
  MoneyTransfer moneyTransfer = MoneyTransfer();



  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black.withOpacity(0),
          backgroundColor: Colors.grey.shade900,
          title: Text('Переводы', style: Theme.of(context).textTheme.headline2),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: CardView(context, moneyFormat.format(balance).toString())),
                  const Padding(padding: EdgeInsets.only(top: 10)),

                  TextFormField(
                    inputFormatters: [maskFormatter],
                    keyboardType: TextInputType.number,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Введите номер карты верно';
                      }
                      else if(value.length != 19){
                        return 'Введите корректно номер карты';
                      }
                      return null;
                    },
                    onSaved: (value){
                      moneyTransfer.card = value;
                    },
                    style: const TextStyle(color: Colors.grey),
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: 'Номер карты',
                      hintText: '0000 0000 0000 0000',
                      labelStyle: TextStyle(color: Colors.grey),
                      hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),

                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите сумму';
                        }
                        try {
                          if (int.parse(value) < 10 ||
                              int.parse(value) > 15000) {
                            return 'Сумма меньше 10р или больше 15 000р';
                          }
                        } on Exception catch (e) {
                          return ('Недопутимый формат');
                        }
                        return null;
                      },
                      onSaved: (value){
                        moneyTransfer.sum = double.parse(value!);
                      },
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'от 10 до 15 000 р',
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 30)),


                   TextFormField(
                       onSaved: (value){
                         moneyTransfer.messageUser = value;
                       },
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius:  BorderRadius.all(Radius.circular(20))
                      ),
                      hintText: 'Сообщение получателю',
                      hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 15)),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              addTransaction(moneyTransfer);
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/transactionOk',
                                  (route)=>false
                              );
                            }
                          },
                          child: const Text('Перевести',
                              style: TextStyle(color: Colors.black)),
                        ),
                    ),
                    )
                ],
              )
                ,
            ),
          ),
        )


      ),
    );
  }
}
