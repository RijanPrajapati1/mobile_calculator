import 'package:flutter/material.dart';

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorView(),
    );
  }
}

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorViewState createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final TextEditingController _controller =
      TextEditingController(); // Single controller for input and output
  double _num1 = 0; // First number
  double _num2 = 0; // Second number
  String _operator = ""; // The operator (+, -, *, /)
  bool _isNewCalculation =
      false; // Flag to check if a new calculation has been performed

  // Function to handle button presses
  void _buttonPressed(String value) {
    setState(() {
      // Clear button
      if (value == "C") {
        _controller.text = "0";
        _num1 = 0;
        _num2 = 0;
        _operator = "";
        _isNewCalculation = false;
      }
      // Backspace button
      else if (value == "<-") {
        if (_controller.text.isNotEmpty) {
          _controller.text =
              _controller.text.substring(0, _controller.text.length - 1);
          if (_controller.text.isEmpty) {
            _controller.text = "0";
          }
        }
      }
      // Operator buttons (+, -, *, /)
      else if (value == "+" || value == "-" || value == "*" || value == "/") {
        if (_controller.text.isNotEmpty && _controller.text != "0") {
          _num1 = double.parse(_controller.text);
          _operator = value;
          _controller.text = "0";
          _isNewCalculation = false; // Prepare for next number
        }
      }
      // Equal button
      else if (value == "=") {
        if (_operator.isNotEmpty && _controller.text.isNotEmpty) {
          _num2 = double.parse(_controller.text);

          switch (_operator) {
            case "+":
              _controller.text = (_num1 + _num2).toString();
              break;
            case "-":
              _controller.text = (_num1 - _num2).toString();
              break;
            case "*":
              _controller.text = (_num1 * _num2).toString();
              break;
            case "/":
              _controller.text =
                  _num2 != 0 ? (_num1 / _num2).toString() : "Error";
              break;
          }

          // After calculating, the next number entered will be considered as the start of a new operation.
          _num1 = 0;
          _num2 = 0;
          _operator = "";
          _isNewCalculation =
              true; // Flag to indicate that a new calculation should start
        }
      }
      // Other buttons (numbers, dot, etc.)
      else {
        if (_controller.text == "0" || _isNewCalculation) {
          _controller.text =
              value; // Reset the display if it's a new calculation
          _isNewCalculation =
              false; // Reset the flag after entering the new number
        } else {
          _controller.text += value; // Append the value to the current input
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculator buttons
    final List<String> buttons = [
      "C",
      "*",
      "/",
      "<-",
      "1",
      "2",
      "3",
      "+",
      "4",
      "5",
      "6",
      "-",
      "7",
      "8",
      "9",
      "*",
      "%",
      "0",
      ".",
      "=",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator App"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Display area (using controller)
          Container(
            padding: const EdgeInsets.all(12.0),
            alignment: Alignment.centerRight,
            child: TextField(
              controller: _controller,
              enabled: false,
              style: const TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  // Adds a border to the TextField
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.blue, // Border color
                    width: 2.0, // Border width
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Buttons grid
          Expanded(
            child: GridView.count(
              crossAxisCount: 4, // 4 buttons per row
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              children: buttons.map((String button) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20.0),
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    _buttonPressed(button);
                  },
                  child: Text(
                    button,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
