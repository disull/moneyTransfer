import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sendmoney/widgets/loginWidget.dart';
import 'package:sendmoney/pages/profile.dart';
import 'package:sendmoney/pages/transactionOk.dart';
import 'package:sendmoney/pages/transfer.dart';
import 'package:sendmoney/pages/userPanel.dart';


int balance = 7200;

Future<void> main ()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp( MaterialApp(
    theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade900,
        fontFamily: 'SourceSansPro-Regular',
        textTheme: const TextTheme(
          headline3: TextStyle(
            fontSize: 32,
            color: Colors.white,
          ),
          headline2: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          headline6: TextStyle(
            fontSize: 13,
            color: Colors.white,
          ),
        )
    ),
    debugShowCheckedModeBanner: false,
    initialRoute: '/loginPage',
    routes: {
      '/loginPage': (context) => LoginWidget(),
      '/userPanel': (context) => UserPanel(),
      '/transfer': (context) => Transfer(balance: balance),
      '/transactionOk': (context) => TransactionOk(),
      '/profile': (context) => Profile(),
    },
  ));
}
