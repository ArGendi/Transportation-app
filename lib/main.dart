import 'package:flutter/material.dart';
import 'package:transportation/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transportation',
      theme: ThemeData(
          fontFamily: 'Changa',
          appBarTheme: AppBarTheme(
            color: primaryColor,
          ),
      ),
      home: Container(),
    );
  }
}