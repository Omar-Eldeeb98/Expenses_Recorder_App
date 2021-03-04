import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart'; // packge to formatt date

class TranactionList extends StatelessWidget {
  final List<Transaction> tranactions;
  final Function deleteTransaction;
  TranactionList(this.tranactions , this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      child: tranactions.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 60,
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
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/empty1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  shadowColor: Colors.green,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 40,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: FittedBox(
                          child:
                              Text('\$' + tranactions[index].amount.toString()),
                        ),
                      ),
                    ),
                    title: Text(
                      tranactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(tranactions[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.cancel_sharp),
                      color: Colors.red,
                      onPressed: ()=> deleteTransaction(tranactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: tranactions.length,
            ),
    );
  }
}
