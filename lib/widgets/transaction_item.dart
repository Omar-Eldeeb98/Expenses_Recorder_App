import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.mediaQuery,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final MediaQueryData mediaQuery;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shadowColor: Colors.green,
      child: ListTile(
        leading: CircleAvatar(
          radius: 40,
          backgroundColor: Colors.purple, //...................
          child: Padding(
            padding: EdgeInsets.all(5),
            child: FittedBox(
              child:
                  Text('\$' + transaction.amount.toString()),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: mediaQuery.size.width > 460
            ? FlatButton.icon(
                icon: Icon(Icons.cancel_sharp),
                label: Text('Delete'),
                textColor: Colors.red,
                onPressed: () =>
                    deleteTransaction(transaction.id),
              )
            : IconButton(
                icon: Icon(Icons.cancel_sharp),
                color: Colors.red,
                onPressed: () =>
                    deleteTransaction(transaction.id),
              ),
      ),
    );
  }
}
