import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sgp/Assets/toggle_screen.dart';
import 'package:sgp/Login.dart';

class forget_pass extends StatefulWidget {
  @override
  fpass_state createState() => fpass_state();
}

class fpass_state extends State<forget_pass> {
  final _email = TextEditingController();

  Future forgetpass() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _email.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                  'Password reset mail is sent to your email! Check the email'),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              Container(
                height: 200,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Text(
                    'Forget Password',
                    style: TextStyle(fontSize: 55),
                    textAlign: TextAlign.center,
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(45),
                      bottomRight: Radius.circular(45),
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.deepOrange, Colors.orange])),
              ),
              SizedBox(
                height: 13,
              ),
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                        width: 240,
                        child: TextField(
                          controller: _email,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          child: const Text(
                            'Send Email',
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.orangeAccent.withOpacity(0.94),
                              onPrimary: Colors.black,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.all(15)),
                          onPressed: forgetpass,
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white70,
                      // border: Border.all(color: Colors.black),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: const Offset(
                            3.0,
                            3.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: const Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Back to Login',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ])));
  }
}
