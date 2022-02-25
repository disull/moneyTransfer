

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sendmoney/my_icons_icons.dart';
import 'package:flip_card/flip_card.dart';


Widget FlipCardView(context, balance){


  return FlipCard(
      front: Center(
        child: Container(
            height: 130,
            width: 320,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.red,
                      Colors.purple,
                    ]
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(balance.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 25),),
                const SizedBox(
                    width: 75,
                    child: Icon(MyIcons.visa_inc__logo_1, color: Colors.white,))
                //const Image(image: AssetImage('assets/icons/visaLogo2.png',))//Text()
              ],

            )
        ),
      ),
      back:  Center(
        child: Container(
            height: 130,
            width: 320,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.red,
                      Colors.purple,
                    ]
                )
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('0000 0000 0000 0000', style: Theme.of(context).textTheme.headline2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('00/00', style: Theme.of(context).textTheme.headline2),
                        Text('CVC: 000', style: Theme.of(context).textTheme.headline2),
                      ],
                  )

                ],
              ),
            )
        ),
      )
  );
}






Widget CardView(context,balance) {

  return  Center(
    child: Container(
        height: 130,
        width: 320,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.red,
                  Colors.purple,
                ]
            )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(balance.toString(),
              style: Theme.of(context).textTheme.headline3,),
            SizedBox(
                width: 75,
                child: const Icon(MyIcons.visa_inc__logo_1, color: Colors.white,))
            //const Image(image: AssetImage('assets/icons/visaLogo2.png',))//Text()
          ],

        )
    ),
  );
}