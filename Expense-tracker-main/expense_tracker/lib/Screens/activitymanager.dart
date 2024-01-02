import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../Components/mnavbar.dart';
import './myhomepage.dart';

// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class ActivityManager extends StatefulWidget {
  const ActivityManager({super.key});

  @override
  State<ActivityManager> createState() => _ActivityManagerState();
}

class _ActivityManagerState extends State<ActivityManager> {
  late DatabaseReference expensesRef;
  List<DataSnapshot> expenseList = [];
  @override
  void initState() {
    super.initState();
    expensesRef = FirebaseDatabase.instance.ref('expenses');
    expensesRef.onValue.listen((event) {
      setState(() {
        expenseList = event.snapshot.children.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
              Color.fromARGB(255, 83, 78, 212),
              Color.fromARGB(255, 28, 28, 28)
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Mnavbar(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
            ),
            Expanded(
              child: expenseList.isEmpty
                  ? const Center(
                      child: Text(
                        'No Expense Added',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : Container(
                      width: 900,
                      child: ListView.builder(
                        itemCount: expenseList.length,
                        itemBuilder: (context, index) {
                          var childData = expenseList[index];
                          var childDataExpenses = childData.children.toList();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Card(
                                color: Colors.black,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      FutureBuilder(
                                        future: FirebaseDatabase.instance
                                            .ref('users')
                                            .child(childData.key.toString())
                                            .get(),
                                        builder: (context, snapshot) {
                                          if (snapshot.data == null) {
                                            return Text(
                                              childData.key.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            );
                                          } else {
                                            return Text(
                                              snapshot.data!
                                                  .child('name')
                                                  .value
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            );
                                          }
                                        },
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.arrow_downward_outlined,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              ListView.builder(
                                itemCount: childDataExpenses.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var expense = childDataExpenses[index];
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${expense.child('Marchantname').value} - ${expense.child('category').value}',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                  'Status : ${expense.child('status').value}'),
                                              Text(
                                                  '${expense.child('Description').value}'),
                                            ],
                                          ),
                                          const Spacer(),
                                          Column(
                                            children: [
                                              Text(
                                                '${expense.child('Amount').value} GBP',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 8),
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Change Status'),
                                                      content: const Text(
                                                          'Please choose the status of the expense'),
                                                      actions: <Widget>[
                                                        GestureDetector(
                                                          onTap: () {
                                                            expense.ref.update({
                                                              'status':
                                                                  'Approved'
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            color: Colors.green,
                                                            child: const Text(
                                                              'Approve',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            expense.ref.update({
                                                              'status':
                                                                  'Rejected'
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Container(
                                                            color: Colors.red,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: const Text(
                                                              'Reject',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              color: Colors.grey,
                                              child: const Text(
                                                'Change Status',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          );
                          //
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
