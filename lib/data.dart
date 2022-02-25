import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sendmoney/model.dart';

List transactions = [
  UserTransaction(
    id: 0,
    name: 'Сбербанк',
    sum: 1200,
    currency: 'Руб',
    dataTime: Timestamp.now(),
  ),
  UserTransaction(
      id: 1,
      name: 'Албфабанк',
      sum: 4200,
      currency: 'Руб',
    dataTime: Timestamp.now(),
  ),
  UserTransaction(
      id: 2,
      name: 'Тинькоф',
      sum: 2200,
      currency: 'Руб',
    dataTime: Timestamp.now(),
  ),
  UserTransaction(
      id: 3,
      name: 'ВТБ',
      sum: 6200,
      currency: 'Руб',
    dataTime: Timestamp.now(),
  ),
  UserTransaction(
      id: 4,
      name: 'Сбер',
      sum: 5200,
      currency: 'Руб',
      dataTime: Timestamp.now(),
  ),
];