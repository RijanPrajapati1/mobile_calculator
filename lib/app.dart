import 'package:flutter/material.dart';
import 'package:mobile_calculator/view/calculator_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalculatorView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
