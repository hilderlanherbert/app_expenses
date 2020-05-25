import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:expenses/models/transaction.dart';

class TransactionList extends  StatelessWidget {

  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(
    this.transactions,
    this.onRemove
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty ? Column(
        children: <Widget>[
          SizedBox(height: 20,
          ),
          Text('Sem transação cadastrada.',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20
          ),
        ),
          SizedBox(height: 20,
          ),
          Container(
            height: 200,
            child: Image.asset('assets/images/waiting.png',
            fit: BoxFit.cover,),
          ),
        ],
      )
     : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          final tr = transactions[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 8
            ),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: FittedBox(
                    child: Text('R\$${tr.value}'),
                  ),
                ),
                title: Text(
                  tr.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text(
                  DateFormat('d MMM y').format(tr.date)
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: (){
                    return onRemove(tr.id);
                  }
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}