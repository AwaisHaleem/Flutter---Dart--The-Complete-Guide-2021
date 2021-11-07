import 'package:flutter/material.dart';
import '/model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList({required this.transactions, required this.deleteTx});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    "No transaction added yet",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * .6,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            })
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (BuildContext contex, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                            child: Text("\$${transactions[index].amount}")),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 400
                        ? TextButton.icon(
                            onPressed: () => deleteTx(transactions[index].id),
                            icon: Icon(Icons.delete),
                            label: Text("Delete"),
                            style: TextButton.styleFrom(
                                primary: Theme.of(context).errorColor),
                          )
                        : IconButton(
                            onPressed: () => deleteTx(transactions[index].id),
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                          ),
                  ),
                );
              },
            ),
    );
  }
}
