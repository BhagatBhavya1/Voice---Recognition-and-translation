//direct sign in button

import 'package:flutter/material.dart';

class signin_dir extends StatelessWidget {
  final String imagepath;
  final Function()? onTap;
  const signin_dir({
    super.key,
    required this.imagepath,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(45),
        ),
        child: Image.asset(
          imagepath,
          height: 60,
        ),
      ),
    );
  }
}
