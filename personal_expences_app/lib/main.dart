import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expences_app/Widgets/chart.dart';
import './Widgets/transaction_list.dart';
import 'Widgets/new_transaction.dart';
import '/model/transaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: "QuickSand",
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold,
                fontSize: 18),
            button: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
      title: "Personal Expenses",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(id: 't1', title: "Shoes", amount: 66.77, date: DateTime.now()),
    // Transaction(id: 't2', title: "Grocery", amount: 20.88, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  bool _showChart = false;

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(addTx: _addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandScape = mediaQuery.orientation == Orientation.landscape;

    var appBar2 = AppBar(
      title: Text("Personal Expenses"),
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(Icons.add),
        ),
      ],
    );

    final txList = Container(
      height: (mediaQuery.size.height -
              appBar2.preferredSize.height -
              mediaQuery.padding.top) *
          .7,
      child: TransactionList(
        transactions: _userTransaction,
        deleteTx: _deleteTransaction,
      ),
    );
    return Scaffold(
      appBar: appBar2,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Show Chart"),
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(
                        () {
                          _showChart = val;
                        },
                      );
                    },
                  )
                ],
              ),
            if (!isLandScape)
              Container(
                height: (mediaQuery.size.height -
                        appBar2.preferredSize.height -
                        mediaQuery.padding.top) *
                    .3,
                child: Chart(recentTransaction: _recentTransactions),
              ),
            if (!isLandScape) txList,
            _showChart
                ? Container(
                    height: (mediaQuery.size.height -
                            appBar2.preferredSize.height -
                            mediaQuery.padding.top) *
                        .7,
                    child: Chart(recentTransaction: _recentTransactions),
                  )
                : txList
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
