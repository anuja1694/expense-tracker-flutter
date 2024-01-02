import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../Components/mnavbar.dart';

class ManagerHomePage extends StatefulWidget {
  const ManagerHomePage({super.key});

  @override
  State<ManagerHomePage> createState() => ManagerHomePageState();
}

class ManagerHomePageState extends State<ManagerHomePage> {
  late DatabaseReference expensesRef;
  List<DataSnapshot> expenseList = [];
  var entertainmentAmount = 0.0;
  var homeAmount = 0.0;
  var travelAmount = 0.0;
  var total = 0.0;
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

  calculateTotalPerUser(List<DataSnapshot> expenseList) {
    var value = 0.0;
    for (int i = 0; i < expenseList.length; i++) {
      value +=
          double.tryParse(expenseList[i].child('Amount').value.toString()) ??
              0.0;
    }
    return value;
  }

  calculateTotal(List<DataSnapshot> expenseList) {
    var value = 0.0;
    for (int i = 0; i < expenseList.length; i++) {
      for (int j = 0; j < expenseList[i].children.toList().length; j++) {
        var child = expenseList[i].children.toList()[j];
        value += double.tryParse(child.child('Amount').value.toString()) ?? 0.0;
      }
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    total = 0.0;
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
              const Mnavbar(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
              ),
              const SizedBox(height: 80),
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
                      'Complete Expenses',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 50,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    const SizedBox(height: 30),
                    ListView.builder(
                      itemCount: expenseList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var userExpense = expenseList[index];
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: FutureBuilder(
                                    future: FirebaseDatabase.instance
                                        .ref('users')
                                        .child(userExpense.key.toString())
                                        .get(),
                                    builder: (context, snapshot) {
                                      if (snapshot.data == null) {
                                        return const Text(
                                          'Loading.....',
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        );
                                      } else {
                                        return Text(
                                          snapshot.data!
                                              .child('Name')
                                              .value
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 24,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: Text(
                                      '${calculateTotalPerUser(userExpense.children.toList())} GBP',
                                      style: const TextStyle(
                                          fontSize: 24,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255))),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                          ],
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        ),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Text('Total :',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Color.fromARGB(255, 255, 255, 255))),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Text('${calculateTotal(expenseList)} GBP',
                              style: const TextStyle(
                                  fontSize: 24,
                                  color: Color.fromARGB(255, 255, 255, 255))),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
