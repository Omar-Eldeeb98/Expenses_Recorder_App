import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_item.dart'; // packge to formatt date

class TranactionList extends StatelessWidget {
  final List<Transaction> tranactions;
  final Function deleteTransaction;
  TranactionList(this.tranactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return tranactions.isEmpty
        ? LayoutBuilder(builder: (context, constarints) {
            return Column(
              children: [
                SizedBox(
                  height: constarints.maxHeight * 0.05,
                ),
                Text(
                  'No Transactions Added Yet!',
                  style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: constarints.maxHeight * 0.03,
                ),
                Container(
                  height: constarints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/empty1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return TransactionItem(
                  transaction: tranactions[index],
                  mediaQuery: mediaQuery,
                  deleteTransaction: deleteTransaction);
            },
            itemCount: tranactions.length,
          );
  }
}
