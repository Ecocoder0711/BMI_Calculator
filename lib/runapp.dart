import 'package:flutter/material.dart';
import 'package:my_bmi/screen/myhomepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
