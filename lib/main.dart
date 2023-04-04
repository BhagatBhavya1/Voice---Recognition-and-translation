import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sgp/Assets/google_auth.dart';
import 'package:sgp/Assets/toggle_screen.dart';
import 'package:sgp/s_t.dart';
// import 's_t.dart';
import 'Login.dart';
import 'Assets/Is_login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  NewWidget createState() => NewWidget();
}

class NewWidget extends State<MyApp> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  check_login c = check_login();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (c.is_login(context)) {
                  return MyHomePage();
                } else {
                  return toggle();
                }
                // c.is_login();
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
