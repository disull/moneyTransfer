import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sendmoney/pages/transfer.dart';
import 'package:sendmoney/widgets/cardView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sendmoney/model.dart';
import '../functions.dart';

final moneyFormat = NumberFormat.currency(
  locale: 'ru',
  symbol: '₽',
  decimalDigits: 2,
);


class UserPanel extends StatefulWidget {

  const UserPanel({Key? key}) : super(key: key);
  @override
  State<UserPanel> createState() => _UserPanelState();



}

class _UserPanelState extends State<UserPanel> {


  String userName = 'Анатолий Хармач';
  String avatarPath = 'assets/image/avatar2.jpeg';
  int balance = 7200;







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,

      appBar: AppBar(
        shadowColor: Colors.black.withOpacity(0),
        backgroundColor: Colors.grey.shade900,
        leading:  PopupMenuButton(
          icon: const Icon(Icons.border_all_sharp, color: Colors.white),
          itemBuilder: (BuildContext context) {
            return [
               PopupMenuItem(child: TextButton(
                   onPressed: () {
                     Navigator.pushNamed(context, '/profile');
                   },
                   child: const Text('Профиль', style: TextStyle(color: Colors.black),))),
              PopupMenuItem(child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/transfer');
                  },
                  child: const Text('Перевести', style: TextStyle(color: Colors.black),))),
              PopupMenuItem(child: TextButton(
                  onPressed: () {
                    signOut();
                    Navigator.pushNamedAndRemoveUntil(context, '/loginPage', (route) => false);
                  },
                  child: const Text('Выйти', style: TextStyle(color: Colors.black),))),
            ];

          },

        ),
        title: Text(userName, style: const TextStyle(color: Colors.white,fontSize: 23)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage(avatarPath),
                    radius: 20,),
                ),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              }
            ),
          ),
        ],

      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 40)),
            FlipCardView(context, moneyFormat.format(balance)),
            ButtonTransaction(),
            WidjetTransactions(),


          ],
        ),
      ),
    );
  }
}

class ButtonTransaction extends StatelessWidget {
  const ButtonTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/transfer');
              },
              child: const Text('Перевести деньги',
                style: TextStyle(color: Colors.black)
                ,)),
        ),
      ),
    );
  }
}


class WidjetTransactions extends StatefulWidget {
  const WidjetTransactions({Key? key}) : super(key: key);

  @override
  _WidjetTransactionsState createState() => _WidjetTransactionsState();
}

class _WidjetTransactionsState extends State<WidjetTransactions> {
  late Future<List<UserTransaction>> transaction;

  @override
  void initState() {
    super.initState();
    transaction = getTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Text('Транзакции',
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Divider(
                height: 5,
                thickness: 2,
                indent: 30,
                endIndent: 30,
                color: Colors.black12,
              ),
            ),
            Expanded(
                child: FutureBuilder<List<UserTransaction>>(
                    future: transaction,
                    builder: (BuildContext context, snapshot) {
                      if(snapshot.hasData && snapshot.data?.length!=0){
                        List<UserTransaction> transaction = snapshot.data as List<UserTransaction>;
                        transaction.sort((a,b)=> b.dataTime.compareTo(a.dataTime));

                        return ListView.builder(
                          itemCount: transaction.length,
                          itemBuilder: (BuildContext context, int index){
                              return ListTile(
                                leading: const Icon(
                                  Icons.payment, color: Colors.white,),
                                title: Center(child: Text(
                                    transaction[index].name, style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline2)),
                                trailing: Text(moneyFormat.format(transaction[index].sum).toString(),
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .headline2,),
                              );
                          },
                        );
                      }
                      else if(snapshot.hasError){
                        return Text('Error - ${snapshot.error}', style: TextStyle(color: Colors.white));
                      }
                      else if(snapshot.data?.length == 0){
                        return Center(child: Text('Вы еще не совершали переводы', style: TextStyle(color: Colors.white, fontSize: 18)));
                      }
                      else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }


                )
            )
          ],
        ),
      ),
    );
  }
}
