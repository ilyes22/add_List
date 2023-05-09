import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../model/transation.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deletetransaction;
  TransactionsList(this.transaction, this.deletetransaction);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(builder: (ctx, Constraints) {
            return SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                      'No added text yet !!',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: Constraints.maxHeight * 0.05,
                    ),
                    SizedBox(
                      height: Constraints.maxHeight * 0.3,
                      child: Image.asset(
                        'assets/img/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: Card(
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 35,
                      child: FittedBox(
                        child: Text(
                          '\$${transaction[index].amount}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      backgroundColor: Colors.purple,
                    ),
                    title: Text(
                      transaction[index].title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMEd().format(transaction[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? TextButton.icon(
                            onPressed: () {
                              deletetransaction(
                                transaction[index].id,
                              );
                            },
                            icon: Icon(
                              Icons.delete,
                            ),
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.red),
                            label: Text(
                              'Delete',
                              // style: TextStyle(color: Colors.red),
                            ),
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () =>
                                deletetransaction(transaction[index].id),
                          ),
                  ),
                ),
              );
            },
            itemCount: transaction.length,
          );
  }
}
