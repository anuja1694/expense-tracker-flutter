import 'package:expense_tracker/Screens/myhomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Screens/managerhomepage.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'Screens/auth_page.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

var isManager = false;
final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Expense Tracker',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Montserrat"),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          initialData: null,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            } else if (snapshot.hasData) {
              return FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.data != null && snapshot.data!.exists) {
                    if (snapshot.data!.child('ismanager').value == true) {
                      isManager = true;
                      return ManagerHomePage();
                    } else {
                      isManager = false;
                      return MyHomePage();
                    }
                  }
                  return Center(child: CircularProgressIndicator());
                },
                future: FirebaseDatabase.instance
                    .ref('users/${FirebaseAuth.instance.currentUser!.uid}')
                    .get(),
              );
            } else {
              return AuthPage();
            }
          },
        ),
      );
}
