import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addTx;

  NewTransactions(this.addTx);

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final _titleController = TextEditingController();
  final _amtController = TextEditingController();
  DateTime _selectDate;

  void _submit() {
    if (_amtController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmt = double.parse(_amtController.text);

    if (enteredTitle.isEmpty || enteredAmt <= 0 || _selectDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmt,
      _selectDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submit(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amtController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submit(),
            ),
            Container(
              height: 60,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectDate == null
                          ? 'No Date Chosen'
                          : 'Picked Date : ${DateFormat.yMd().format(_selectDate)}',
                    ),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _presentDate,
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              child: const Text('Add Transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _submit,
            )
          ],
        ),
      ),
    );
  }
}
