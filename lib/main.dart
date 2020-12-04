import 'package:flutter/material.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      home: SimpleCalculator(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String output = "0.0";
  double num1 = 0, num2 = 0;
  String _output = "0.0";
  String operand = "";

  void onPressed(String textButton) {
    if (textButton == "C") {
      output = "0.0";
      num1 = 0;
      num2 = 0;
      _output = "0.0";
      operand = "";
    } else if (textButton == "×" ||
        textButton == "÷" ||
        textButton == "+" ||
        textButton == "-") {
      num1 = double.parse(output);
      operand = textButton;
      //_output = "0";
    } else if (textButton == ".") {
      if (_output.contains(".")) {
        print("Error 1");
        return;
      } else {
        _output += textButton;
      }
    } else if (textButton == "=") {
      num2 = double.parse(output);
      if (operand == "+") {
        _output = (num1 + num2).toString();
      } else if (operand == "×") {
        _output = (num1 * num2).toString();
      } else if (operand == "÷") {
        if (num2 == 0) {
          print("Error 2");
          return;
        }
        _output = (num1 / num2).toString();
      } else if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      num1 = 0;
      num2 = 0;
      operand = "";
    } else {
      _output = textButton;
    }
    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
    });
  }

  Text builtText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }

  Widget buildButton(
      [String text, Color color = Colors.black12, Widget child]) {
    return Expanded(
      child: ButtonTheme(
        height: 60,
        child: FlatButton(
          onPressed: () => onPressed(text),
          child: child ??= builtText(text),
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide(color: Colors.white, width: 0.5),
          ),
        ),
      ),
    );
  }

  Row bulidRow(String str1, String str2, String str3, String str4) {
    return Row(
      children: [
        buildButton(str1),
        buildButton(str2),
        buildButton(str3),
        buildButton(str4, Colors.black26),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Simple Calculator"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 40, 15, 0),
              child: Text(
                output,
                style: TextStyle(fontSize: 56),
              ),
            ),
            // Expanded(
            //   child: Divider(
            //     color: Colors.transparent,
            //   ),
            // ),
            Expanded(
              child: SizedBox(),
            ),
            // SizedBox(
            //   width: double.infinity,
            //   height: 158,
            // ),
            Row(
              children: [
                buildButton("C", Colors.redAccent),
                buildButton(null, Colors.black26, Icon(Icons.backspace)),
                buildButton("+/-", Colors.black26),
                buildButton("%", Colors.black26),
              ],
            ),
            bulidRow("7", "8", "9", "÷"),
            bulidRow("4", "5", "6", "×"),
            bulidRow("3", "2", "1", "+"),

            Row(
              children: [
                buildButton("0", Colors.black26),
                buildButton(".", Colors.black26),
                buildButton("=", Colors.black26),
                buildButton("-", Colors.black26),
              ],
            ),
          ],
        ));
  }
}
