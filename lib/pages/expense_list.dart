import 'package:expenseapp/models/expense.dart';
import 'package:expenseapp/widgets/expence_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({Key? key}) : super(key: key);

  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  //dumy data-- örnek veri

  final List<Expense> expenses = [
    Expense(
        name: "Yiyecek",
        date: DateTime.now(),
        price: 200,
        category: Category.food),
    Expense(
        name: "Flutter Kurs",
        date: DateTime.now(),
        price: 200,
        category: Category.education),
    Expense(
        name: "Rent a Car",
        date: DateTime.now(),
        price: 200,
        category: Category.travel),
    Expense(
        name: "Ofis",
        date: DateTime.now(),
        price: 200,
        category: Category.work),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 400,
            child: Text("Grafikler"),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return ExpenceItem(expenses[index]);
                }),
          )
        ],
      ),
    );
  }
}
