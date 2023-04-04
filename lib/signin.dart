import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sgp/Login.dart';
import 'package:sgp/s_t.dart';

class Signin extends StatefulWidget {
  final VoidCallback showLoginpage;
  const Signin({Key? key, required this.showLoginpage}) : super(key: key);
  @override
  set_sign createState() => set_sign();
}

class set_sign extends State<Signin> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController conf_pass = TextEditingController();

  void dispose() {
    _email.dispose();
    _pass.dispose();
    conf_pass.dispose();
    super.dispose();
  }

  Future Signup() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text.trim(), password: _pass.text.trim());
  }

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
                  padding: const EdgeInsets.only(top: 90),
                  child: Text(
                    'Sign up',
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
                  height: 300,
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
                        height: 10,
                      ),
                      SizedBox(
                        width: 240,
                        child: TextField(
                          controller: _pass,
                          obscureText: true,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      SizedBox(
                        width: 240,
                        child: TextField(
                          controller: conf_pass,
                          obscureText: true,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: 100,
                        child: ElevatedButton(
                          child: const Text(
                            'Sign up',
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
                          onPressed: () async {
                            // if (_pass == conf_pass) {
                            Signup();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ),
                            );
                          },
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
                  Text(
                    'Already have a account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.showLoginpage,
                    child: Text(
                      'Log in',
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
