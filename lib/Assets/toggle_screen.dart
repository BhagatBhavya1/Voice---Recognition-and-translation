import 'package:flutter/widgets.dart';
import 'package:sgp/Login.dart';
import 'package:sgp/signin.dart';

class toggle extends StatefulWidget {
  const toggle({Key? key}) : super(key: key);
  @override
  change_screen createState() => change_screen();
}

class change_screen extends State<toggle> {
  bool showLoginpage = true;

  void toggelscreen() {
    setState(() {
      showLoginpage = !showLoginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginpage) {
      return Login(showRegistorpage: toggelscreen);
    } else {
      return Signin(showLoginpage: toggelscreen);
    }
  }
}
