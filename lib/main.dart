import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Calculator",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SimpleCalc(),
    );
  }
}

class SimpleCalc extends StatefulWidget {
  const SimpleCalc({super.key});

  @override
  State<SimpleCalc> createState() => _SimpleCalcState();
}

class _SimpleCalcState extends State<SimpleCalc> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 36.0;
  double resultFontSize = 46.0;

  // buttonPressed function to handle all operations
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
      } else if (buttonText == "Del") {
        equation = equation.substring(0, equation.length - 1);
        if (equation.isEmpty) {
          equation = "0";
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll("x", "*");

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
        } catch (e) {
          // ignore: avoid_print
          print("An error occured!");
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation += buttonText;
        }
      }
    });
  }

  // General button Widget
  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Padding(
      padding: const EdgeInsets.all(0.75),
      child: Container(
        // Covering 10% of the device's height
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        color: buttonColor,
        child: ElevatedButton(
          onPressed: () => buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 36.0,
                color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Flutter Calc",
          style: TextStyle(fontWeight: FontWeight.w300),
        )),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          const Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                // Covering 75% of the device's width
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C", 1, Colors.redAccent),
                        buildButton("Del", 1, Colors.blueGrey),
                        buildButton("/", 1, Colors.blueGrey)
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.blueAccent),
                        buildButton("8", 1, Colors.blueAccent),
                        buildButton("9", 1, Colors.blueAccent)
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.blueAccent),
                        buildButton("5", 1, Colors.blueAccent),
                        buildButton("6", 1, Colors.blueAccent)
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, Colors.blueAccent),
                        buildButton("2", 1, Colors.blueAccent),
                        buildButton("3", 1, Colors.blueAccent)
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(".", 1, Colors.blueAccent),
                        buildButton("0", 1, Colors.blueAccent),
                        buildButton("00", 1, Colors.blueAccent)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("x", 1, Colors.blueGrey),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("-", 1, Colors.blueGrey),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("+", 1, Colors.blueGrey),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("=", 2, Colors.redAccent),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
