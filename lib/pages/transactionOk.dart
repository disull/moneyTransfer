import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sendmoney/model.dart';
import 'package:sendmoney/pages/userPanel.dart';

class TransactionOk extends StatelessWidget {
  const TransactionOk({Key? key}) : super(key: key);

  @override
  Widget  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [Icon(Icons.check, color: Colors.white, size: 100,),
                    Text('Перевод выполнен', style: TextStyle(color: Colors.white, fontSize: 20)),],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) => UserPanel()
                            ),

                                (route)=>false
                        );
                      },
                      child: const Text('Вернуться', style: TextStyle(color: Colors.black, fontSize: 20),)),
                ),
              )
            ]

              ),
        ),
    );
  }
}
