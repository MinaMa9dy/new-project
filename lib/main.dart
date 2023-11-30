import 'package:flutter/material.dart';

void main() {
  runApp(MyCalculatorApp());
}

class MyCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  void _buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _clear();
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "*" ||
        buttonText == "/") {
      _setOperand(buttonText);
    } else if (buttonText == "=") {
      _calculate();
    } else {
      _appendNumber(buttonText);
    }
  }

  void _clear() {
    setState(() {
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    });
  }

  void _setOperand(String newOperand) {
    setState(() {
      operand = newOperand;
      num1 = double.parse(_output);
      _output = "0";
    });
  }

  void _appendNumber(String num) {
    setState(() {
      if (_output == "0") {
        _output = num;
      } else {
        _output += num;
      }
    });
  }

  void _calculate() {
    setState(() {
      num2 = double.parse(_output);
      switch (operand) {
        case "+":
          _output = (num1 + num2).toString();
          break;
        case "-":
          _output = (num1 - num2).toString();
          break;
        case "*":
          _output = (num1 * num2).toString();
          break;
        case "/":
          _output = (num1 / num2).toString();
          break;
      }
      operand = "";
      num1 = double.parse(_output);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(fontSize: 48),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: 16,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _buttonPressed(buttons[index]);
                    },
                    child: Container(
                      color: isOperator(buttons[index])
                          ? Colors.orange
                          : Colors.grey[300],
                      child: Center(
                        child: Text(
                          buttons[index],
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  final List<String> buttons = [
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    '*',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '=',
    '+',
  ];

  bool isOperator(String buttonText) {
    return buttonText == '+' ||
        buttonText == '-' ||
        buttonText == '*' ||
        buttonText == '/';
  }
}
