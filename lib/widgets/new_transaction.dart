import 'dart:io'; // to detect the platform that the app run on it /

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransaction;

  NewTransaction(this._addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget._addNewTransaction(
      titleController.text,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop(); //-------------------------
  }

  void _showingDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      //if (pickedDate == null) {
      //   return;
      //  }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                scrollPadding: EdgeInsets.all(5.0),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[700]),
                    // hintText: 'Title',
                    labelText: 'Title',
                    labelStyle: TextStyle(fontSize: 20.0),
                    fillColor: Colors.white70),
                controller: titleController,
                onSubmitted: (_) => submitData,
                // onChanged: (String value) {
                // titleInput = value;
                // },
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                scrollPadding: EdgeInsets.all(5.0),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[700]),
                    //  hintText: 'Amount',
                    labelText: 'Amount',
                    labelStyle: TextStyle(fontSize: 20.0),
                    fillColor: Colors.white70),

                // onChanged: (String value) => amountInput = value,
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData,
              ),
              Container(
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Selected!'
                            : 'Picked Date : ' +
                                DateFormat.yMd().format(_selectedDate),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Platform.isIOS
                        ? CupertinoButton(
                            color: Colors.blue,
                            child: Text(
                              'Choose The Date',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: _showingDatePicker,
                          )
                        : RaisedButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                            color: Colors.green,
                            textColor: Colors.white,
                            onPressed: _showingDatePicker,
                            child: Text(
                              'Choose The Date',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          )
                  ],
                ),
              ),
              RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0)),
                color: Colors.purple,
                textColor: Colors.white,
                onPressed: submitData,
                // print(titleInput);
                // print(amountInput);
                // print(titleController.text);
                // print(amoutController.text);

                child: Text(
                  'Add transaction',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
