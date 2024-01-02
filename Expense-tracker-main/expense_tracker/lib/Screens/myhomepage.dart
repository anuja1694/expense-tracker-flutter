import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../Components/navbar.dart';
// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DatabaseReference expensesRef;
  var entertainmentAmount = 0.0;
  var homeAmount = 0.0;
  var travelAmount = 0.0;
  var total = 0.0;
  @override
  void initState() {
    super.initState();
    expensesRef = FirebaseDatabase.instance
        .ref('expenses/${FirebaseAuth.instance.currentUser!.uid}');
    expensesRef.onValue.listen((event) {
      calculateCategoryExpenses(event.snapshot.children.toList());
    });
  }

  calculateCategoryExpenses(List<DataSnapshot> expenseList) {
    if (expenseList.isNotEmpty) {
      for (var i = 0; i < expenseList.length; i++) {
        if (expenseList[i].child('category').value.toString() ==
            'Entertainment') {
          entertainmentAmount += double.tryParse(
                  expenseList[i].child('Amount').value.toString()) ??
              0.0;
        } else if (expenseList[i].child('category').value == 'Home') {
          homeAmount += double.tryParse(
                  expenseList[i].child('Amount').value.toString()) ??
              0.0;
        } else if (expenseList[i].child('category').value == 'Travel') {
          travelAmount += double.tryParse(
                  expenseList[i].child('Amount').value.toString()) ??
              0.0;
        }
      }
      setState(() {
        total = entertainmentAmount + homeAmount + travelAmount;
      });
    } else {
      entertainmentAmount = homeAmount = travelAmount = total = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Navbar(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
              ),
              const SizedBox(height: 80),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 900,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(115, 0, 0, 0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 60),
                        const Text(
                          'Expenses',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 50,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        const SizedBox(height: 30),
                        // Row(

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              child: Icon(
                                Icons.food_bank_outlined,
                                color: Colors.yellow,
                                size: 24.0,
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: Text('Entertainment :',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 0, 0, 0),
                              child: Text('$entertainmentAmount GBP',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              child: Icon(
                                Icons.home_max_outlined,
                                color: Colors.yellow,
                                size: 24.0,
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: Text('Home :',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 0, 0, 0),
                              child: Text('$homeAmount GBP',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              child: Icon(
                                Icons.travel_explore_outlined,
                                color: Colors.yellow,
                                size: 24.0,
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: Text('Travel :',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 0, 0, 0),
                              child: Text('$travelAmount GBP',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: Text('Total :',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 0, 0, 0),
                              child: Text('$total GBP',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                            ),
                          ],
                        ),
                        const SizedBox(height: 60),

                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              // ),
            ],
          ),
          // ],
        ),
      ),
    );
    // );
  }
}
