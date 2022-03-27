import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final ThemeData tema = ThemeData();

    return MaterialApp(
      home: MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: tema.textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: Random().nextDouble().toString(),
      title: "conta",
      value: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: "conta",
      value: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: "conta",
      value: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: "conta",
      value: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: "conta",
      value: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: "conta",
      value: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: "conta",
      value: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: "conta",
      value: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: "conta",
      value: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: "conta",
      value: 100,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((tr) => tr.date.isAfter(DateTime.now().subtract(
              Duration(days: 7),
            )))
        .toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Despesas pessoais'),
      actions: [
        IconButton(
            onPressed: () => openTransactionFormModal(context),
            icon: Icon(Icons.add))
      ],
    );
    final avaliableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                height: avaliableHeight * 0.3,
                child: Chart(recentTransaction: _recentTransactions)),
            Container(
              height: avaliableHeight * 0.7,
              child: TransactionList(
                transactions: _transactions,
                onRemove: _deleteTransaction,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
