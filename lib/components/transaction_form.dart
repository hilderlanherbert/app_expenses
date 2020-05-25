import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends  StatefulWidget {

  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {

  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  _subimit(){
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0 || selectedDate == null) {
      return;
    }
    this.widget.onSubmit(title, value, selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2019),
    lastDate: DateTime.now()
    ).then((pickedDate){
      if (pickedDate == null) {
        return;
      }

      setState(() {
      selectedDate = pickedDate;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Título'
              ),
            ),
            TextField(
              controller: valueController,
              keyboardType: TextInputType.numberWithOptions(decimal:true),
              onSubmitted: (value) => _subimit(),
              decoration: InputDecoration(
                labelText: 'Valor (R\$)'
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                     selectedDate == null ? 'Nenhuma data selecionada!' :
                      'Data selecionada: ${DateFormat('dd/MM/y').format(selectedDate)}'
                      ),
                  ),
                    FlatButton(
                      textColor: Colors.purple,
                      child: Text(
                        'Selecionar Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      onPressed: _showDatePicker,
                    ),
                ],
              ),
            ),
            RaisedButton(
              color: Colors.purple,
              child: Text("Nova Transação",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              textColor: Colors.white,
              onPressed: _subimit,
            ),
          ],
        ),
      ),
    );
  }
}