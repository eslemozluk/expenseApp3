import 'package:expenseapp/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenceItem extends StatelessWidget {
  const ExpenceItem(
    this.expense, {
    Key? key,
  }) : super(key: key);
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(expense.name),
            Row(
              children: [
                Text("${expense.price.toStringAsFixed(2)}₺"),
                const Spacer(),
                const SizedBox(width: 8),
                Icon(categoryIcons[expense.category]),
                const SizedBox(width: 8),
                Text(expense.formattedDate)
              ],
            )
          ],
        ),
      ),
    );
  }
}
