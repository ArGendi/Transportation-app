import 'package:flutter/material.dart';
import 'package:transportation/constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:transportation/screens/make_order.dart';
import 'package:transportation/widgets/custom_textfield.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transportation',
      theme: ThemeData(
          fontFamily: 'Changa',
          appBarTheme: AppBarTheme(
            color: primaryColor,
          ),
      ),
      home: MakeOrder(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        Locale('ar', ''),
      ],
      locale: Locale('ar', ''),
    );
  }
}