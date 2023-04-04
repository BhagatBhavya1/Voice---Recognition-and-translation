import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:sgp/Assets/google_auth.dart';
import 'package:sgp/forget_pass.dart';
import 'package:sgp/signin.dart';
import 's_t.dart';
import 'Assets/Squaretil.dart';
import 'signin.dart';

class Login extends StatefulWidget {
  final VoidCallback showRegistorpage;
  Login({Key? key, required this.showRegistorpage}) : super(key: key);
  @override
  _statelogin createState() => _statelogin();
}

class _statelogin extends State<Login> {
//Google autg0

  //initialize firebase

  static Future<User?> loginUsingemailpassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("User not found");
      }
    }
    return user;
  }

  //VAriable
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 90),
                child: Text(
                  'Login',
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
                height: 250,
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
                            hintText: 'Username',
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => forget_pass()));
                      },
                      child: Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 23, vertical: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Forget Password?',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            )
                          ],
                        ),
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
                          'Sign in',
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
                          User? user = await loginUsingemailpassword(
                              email: _email.text,
                              password: _pass.text,
                              context: context);
                          print(user);
                          if (user != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => MyHomePage()));
                          }
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
            Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    )),
                    Text(' Or Continue with ',
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    )),
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                signin_dir(
                    imagepath: 'assets/images/images.png',
                    onTap: () {
                      if (AuthService().signinWithGoogle()) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(),
                            ));
                      }
                    }),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a Member?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: widget.showRegistorpage,
                  child: Text(
                    'Registor now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
