import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.orange),
      ),
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String displayText = '';
  double? firstOperand;
  String? operator;
  double? previousResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CalculaCool'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              displayText,
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton('7'),
              buildButton('8'),
              buildButton('9'),
              buildButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton('4'),
              buildButton('5'),
              buildButton('6'),
              buildButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton('1'),
              buildButton('2'),
              buildButton('3'),
              buildButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton('0'),
              buildButton('.'),
              buildButton('='),
              buildButton('+'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton('C'),
              buildDeleteButton(), // Nuevo botón de eliminación
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButton(String buttonText) {
    return ElevatedButton(
      onPressed: () {
        onButtonPressed(buttonText);
      },
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  Widget buildDeleteButton() {
    return ElevatedButton(
      onPressed: () {
        onDeleteButtonPressed();
      },
      child: Icon(Icons.backspace, size: 20.0),
    );
  }

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        calculateResult();
      } else if (isNumeric(buttonText)) {
        displayText += buttonText;
      } else if (buttonText == '.') {
        if (!displayText.contains('.')) {
          displayText += buttonText;
        }
      } else if (buttonText == 'C') {
        clearDisplay();
      } else {
        // Handle operators
        if (firstOperand != null && operator != null) {
          calculateResult();
        }
        firstOperand = double.parse(displayText);
        operator = buttonText;
        displayText = '';
      }
    });
  }

  void calculateResult() {
    if (firstOperand != null && operator != null && displayText.isNotEmpty) {
      double secondOperand = double.parse(displayText);
      switch (operator) {
        case '+':
          previousResult = firstOperand! + secondOperand;
          displayText = previousResult.toString();
          break;
        case '-':
          previousResult = firstOperand! - secondOperand;
          displayText = previousResult.toString();
          break;
        case '*':
          previousResult = firstOperand! * secondOperand;
          displayText = previousResult.toString();
          break;
        case '/':
          if (secondOperand != 0) {
            previousResult = firstOperand! / secondOperand;
            displayText = previousResult.toString();
          } else {
            displayText = 'Error';
          }
          break;
      }
      // No es necesario restablecer después de completar la operación
    }
  }

  void clearDisplay() {
    setState(() {
      displayText = '';
      firstOperand = null;
      operator = null;
      previousResult = null;
    });
  }

  void onDeleteButtonPressed() {
    setState(() {
      if (displayText.isNotEmpty) {
        displayText = displayText.substring(0, displayText.length - 1);
      }
    });
  }

  bool isNumeric(String buttonText) {
    return double.tryParse(buttonText) != null;
  }
}
