import 'package:flutter/material.dart';
import '../widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDays = DateTime.now().subtract(new Duration(days: index));
      double totalTransactionSum = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDays.day &&
            recentTransactions[i].date.month == weekDays.month &&
            recentTransactions[i].date.year == weekDays.year) {
          totalTransactionSum += recentTransactions[i].amount;
        }
      }
      //  print(DateFormat.E().format(weekDays)); //just for testing...
      //  print(totalTransactionSum); //just for testing...
      return {
        'day': DateFormat.E().format(weekDays).substring(0, 1),
        'amount': totalTransactionSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(groupedTransactionsValues);  // just for testing...
    return Card(
      elevation: 10,
      shadowColor: Colors.greenAccent[700],
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...groupedTransactionsValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  data['day'],
                  data['amount'],
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending,
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
