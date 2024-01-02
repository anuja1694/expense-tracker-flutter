import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../Components/navbar.dart';

// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
const List<String> list = <String>['Entertainment', 'Home', 'Travel'];

class AddExpenses extends StatefulWidget {
  AddExpenses({super.key});

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  String dropdownValue = list.first;

  // final entertainmentController = dropdownValue;
  var merchantnameController = new TextEditingController();
  var descriptionController = new TextEditingController();
  var amountController = new TextEditingController();

  final databaseRef = FirebaseDatabase.instance.ref();

  void openFiles() async {
    FilePickerResult? resultFile =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    if (resultFile != null) {
      PlatformFile file = resultFile.files.first;
      setState(() {
        fileresult = file;
      });
      print(file.name);
      print(file.bytes);
      print(file.extension);
      print(file.path);
    } else {
      print('No file selected');
    }
  }

  PlatformFile? fileresult;
  DateTime _dateTime = DateTime.now();
  void _showdate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        _dateTime = value ?? DateTime.now();
      });
    });
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
                        SizedBox(height: 60),
                        Text(
                          'Add Expenses',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 50,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Text(
                                  "Category",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                )),
                            SizedBox(width: 30),
                            DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String? value) => setState(() {
                                dropdownValue = value!;
                              }),
                              items: list.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Text("Merchant",
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                            255, 255, 255, 255)))),
                            SizedBox(width: 30),
                            // Text("hi",
                            //     style: TextStyle(
                            //         color: Color.fromARGB(255, 255, 255, 255)))
                            Container(
                              // height: 70,
                              width: 120,
                              child: TextFormField(
                                controller: merchantnameController,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Merchantname',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Text("Amount in Pound",
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                            255, 255, 255, 255)))),
                            SizedBox(width: 30),
                            // Text("hi",
                            //     style: TextStyle(
                            //         color: Color.fromARGB(255, 255, 255, 255)))
                            Container(
                              // height: 70,
                              width: 120,
                              child: TextFormField(
                                controller: amountController,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'amount',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Text("Description",
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                            255, 255, 255, 255)))),
                            SizedBox(width: 20),
                            // Text("hi",
                            //     style: TextStyle(
                            //         color: Color.fromARGB(255, 255, 255, 255)))
                            Container(
                              width: 120,
                              child: TextFormField(
                                controller: descriptionController,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Description',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Text("Date",
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                            255, 255, 255, 255)))),
                            SizedBox(width: 60),
                            GestureDetector(
                              onTap: () {
                                _showdate();
                              },
                              child: Container(
                                  width: 100,
                                  height: 20,
                                  color: Colors.blue,
                                  child: Center(
                                    child: Text(
                                      "Choose date",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                  )),
                            ),
                            SizedBox(width: 20),
                            Text(_dateTime.toString(),
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)))
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Text("Attach bills",
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                            255, 255, 255, 255)))),
                            SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                openFiles();
                              },
                              child: Container(
                                  width: 100,
                                  height: 20,
                                  color: Colors.blue,
                                  child: Center(
                                    child: Text(
                                      "Open File",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                  )),
                            ),
                            SizedBox(width: 20),
                            Text(fileresult?.name ?? 'no file',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)))
                          ],
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            insertData(
                                merchantnameController.text,
                                descriptionController.text,
                                dropdownValue,
                                _dateTime.toString(),
                                amountController.text);
                          },
                          child: Container(
                              alignment: Alignment.center,
                              width: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  gradient: const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xFF8A2387),
                                        Color(0xFF94057),
                                        Color(0xFFF27121)
                                      ])),
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  'Add ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void insertData(String Merchantname, String Description, String dropdownValue,
      String dateTime, String amount) {
    var userExpenseRef = databaseRef
        .child("expenses")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .ref
        .push();
    userExpenseRef.set({
      'Marchantname': Merchantname,
      'Description': Description,
      'category': dropdownValue,
      'Date': dateTime,
      'Amount': amount
    });
    merchantnameController.clear();
    descriptionController.clear();
    amountController.clear();
  }
}
