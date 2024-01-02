import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../Components/navbar.dart';
import './myhomepage.dart';

// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  late DatabaseReference expensesRef;

  List<DataSnapshot> expenseList = [];
  @override
  void initState() {
    super.initState();
    expensesRef = FirebaseDatabase.instance
        .ref('expenses/${FirebaseAuth.instance.currentUser!.uid}');
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
            const Navbar(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
            ),
            Expanded(
              child: expenseList.length == 0
                  ? Center(
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
                          return Card(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${childData.child('Marchantname').value} - ${childData.child('category').value}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                          '${childData.child('Description').value}'),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Text(
                                        '${childData.child('Amount').value} EUR',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 20),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text('Alert'),
                                                  content: const Text(
                                                      'Do you want to remove this expense? '),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .labelLarge,
                                                      ),
                                                      child: const Text('No'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .labelLarge,
                                                      ),
                                                      child: const Text('Yes'),
                                                      onPressed: () {
                                                        childData.ref.remove();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                          //
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.redAccent,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
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
