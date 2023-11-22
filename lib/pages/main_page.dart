import 'package:expenseapp/pages/expense_list.dart';
import 'package:expenseapp/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 194, 225, 222),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Expense App"),
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color.fromARGB(255, 255, 255, 255)),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context, builder: (ctx) => NewExpense());
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: ExpenseList(),
    );
  }
}
