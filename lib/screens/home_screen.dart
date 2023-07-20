import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String userInput = "";
String result = "0";

List<String> buttonList = [
  "AC",
  "(",
  ")",
  "/",
  "7",
  "8",
  "9",
  "*",
  "4",
  "5",
  "6",
  "+",
  "1",
  "2",
  "3",
  "-",
  "C",
  "0",
  ".",
  "="
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('My Calculator ...'),
          ),
          body: Column(
            children: [
              Container(
                child: resultWidget(),
              ),
              Expanded(child: buttonWidget())
            ],
          )),
    );
  }

  //result widget
  Widget resultWidget() {
    return Container(
        color: const Color.fromARGB(238, 255, 255, 255),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: Text(
                userInput,
                style: const TextStyle(fontSize: 28, color: Colors.black),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: Text(
                result,
                style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            )
          ],
        ));
  }

  Widget buttonWidget() {
    return Container(
      padding: const EdgeInsets.all(8),
      color: const Color.fromARGB(255, 201, 201, 201),
      child: GridView.builder(
          itemCount: buttonList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 12),
          itemBuilder: ((context, index) {
            return button(buttonList[index]);
          })),
    );
  }

  getColor(String text) {
    if (text == "*" ||
        text == "/" ||
        text == "+" ||
        text == "-" ||
        text == "C" ||
        text == ")" ||
        text == "(") {
      return Colors.red;
    }
    if (text == "=" || text == "AC") {
      return Colors.white;
    }
    return Colors.indigoAccent;
  }

  backgroundColor(String text) {
    if (text == "AC") {
      return Colors.redAccent;
    }
    if (text == "=") {
      return Colors.green;
    }
    return Colors.white;
  }

  Widget button(String text) {
    return InkWell(
      onTap: (() {
        setState(() {
          handleButtonPress(text);
        });
      }),
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor(text),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 1,
                  spreadRadius: 1)
            ]),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: getColor(text),
                fontSize: 27,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  handleButtonPress(String text) {
    if (text == "AC") {
      userInput = "";
      result = "0";
      return;
    }

    if (text == "C") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return null;
      }
    }

    if (text == "=") {
      result = calculate();
      userInput = result;
      if (userInput.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", " ");
      }

      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", " ");
      }
      return;
    }

    userInput = userInput + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }
}
