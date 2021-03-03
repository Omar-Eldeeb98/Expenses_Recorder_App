import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  //final List<Transaction> transactions = [];

  // String titleInput; //--------------------
  // String amountInput; //-------------------------

  //final titleController = TextEditingController();
  //final amoutController = TextEditingController();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTranactionList = [
    
    Transaction(
      id: 't1',
      title: 'New Shirt',
      amount: 22.58,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'New Shoes',
      amount: 50.67,
      date: DateTime.now(),
    ),
      
  ];


  List<Transaction> get _recentTransactions {
    return _userTranactionList.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(   // if tx.date is after this date it will be true .
        new Duration(days: 7),

      ));
    }).toList();
  }

  void _addNewTransaction(String title, double amount) {
    final newTransaction = new Transaction(
      title: title,
      amount: amount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTranactionList.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (bContext) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
        ),
        centerTitle: true,
        leading: Padding(
          child: Image.asset(
            'assets/images/logo.png',
          ),
          padding: const EdgeInsets.all(8.0),
        ),
        actions: [
          IconButton(
            iconSize: 28.0,
              icon: Icon(
                Icons.add_circle_outline_outlined,
              ),
              onPressed: () => _startAddNewTransaction(context)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TranactionList(_userTranactionList),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _startAddNewTransaction(context),
        elevation: 20,
      ),
    );
  }
}
