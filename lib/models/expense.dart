import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { food, education, travel, work }

const categoryIcons = {
  Category.food: Icons.food_bank,
  Category.education: Icons.cast_for_education,
  Category.travel: Icons.car_rental,
  Category.work: Icons.business,
};

class Expense {
  final String id;
  final String name;
  final double price;
  final DateTime date;
  final Category category;

  Expense(
      {required this.name,
      required this.date,
      required this.price,
      required this.category})
      : id = uuid.v4();

  //getter method--- değişken gibi davranan metot
  //setter method-- bir değişkenin değerini değiştiren metot
  String get formattedDate {
    var formatter = DateFormat.yMd();
    return formatter.format(date);
  }
}
