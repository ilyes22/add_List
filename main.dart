import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:third_app/chart.dart';
import 'package:third_app/widget/new_transaction.dart';
import './model/transation.dart';
import './screen/newpage.dart';

import './widget/transaction_list.dart';

void main() {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

final List<Transaction> usertransaction = [];
bool _showChart = false;

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void newUserTransaction(String title, double amount, DateTime selectdate) {
    final newtx = Transaction(
        title: title,
        amount: amount,
        date: selectdate,
        id: DateTime.now().toString());

    setState(() {
      usertransaction.add(newtx);
    });
  }

  void _creatnewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(newUserTransaction),
          );
        });
  }

  List<Transaction> get _recentTransaction {
    return usertransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      usertransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final islanscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      actions: [
        IconButton(
          onPressed: () => _creatnewTransaction(context),
          icon: const Icon(Icons.add),
        ),
      ],
      // iconTheme: IconButton(onPressed:(){} , Icon: Icon()),
      title: const Text(
        'Ilyes Notes ',
        textAlign: TextAlign.center,
      ),
    );

    final txTransactionWidget = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.8,
      child: TransactionsList(usertransaction, _deleteTransaction),
    );
    return MaterialApp(
      theme: ThemeData(
          textTheme: ThemeData.light().textTheme.copyWith(
                  bodyLarge: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.purple,
          ),
          primaryColor: Colors.purple,
          accentColor: Colors.pinkAccent),
      home: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (islanscape)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Show Chart',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                      Switch(
                        value: _showChart,
                        onChanged: (val) {
                          setState(() {
                            _showChart = val;
                          });
                        },
                      ),
                    ],
                  ),
                if (islanscape)
                  _showChart
                      ? Container(
                          height: (MediaQuery.of(context).size.height -
                                  appBar.preferredSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.7,
                          child: Chart(_recentTransaction),
                        )
                      : txTransactionWidget,
                if (!islanscape)
                  Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.25,
                    child: Chart(_recentTransaction),
                  ),
                if (!islanscape) txTransactionWidget
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _creatnewTransaction(context),
          child: const Icon(Icons.add),
        ),
      ),
      routes: {
        'Hello': (ctx) => DataUpdate(),
      },
    );
  }
}
