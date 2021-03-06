import 'package:flutter/material.dart';
import 'dart:math';

import './models/transaction.dart';
import './components/transaction_form.dart';
import './components/transaction_list.dart';
import './components/chart.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(fontFamily: 'OpenSans', fontSize: 20,
            )
          )
        )
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


   _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (cxt) {
        return TransactionForm(_addTransaction);
      }
    );
  }

  _addTransaction(String title, double value, DateTime date) {
   final newTransaction = Transaction(
     id: Random().nextDouble().toString(),
     title: title,
     value: value,
     date: date
   );

   setState((){
     _transactions.add(newTransaction);
   });

   Navigator.of(context).pop();

 }

 _deleteTransaction(String id){
   setState(() {
     _transactions.removeWhere((tr){
       return tr.id == id;
     });
   });
 }

  final List<Transaction> _transactions = [

 ];

 List<Transaction> get _recentTransactions {
   return _transactions.where((tr) => tr.date.isAfter(DateTime.now().
   subtract(Duration(days: 7)))).toList();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context)
            )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_transactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
    );
  }
}




  



