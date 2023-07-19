import 'package:flutter/material.dart';

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
                style: const TextStyle(fontSize: 25),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: Text(
                result,
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            )
          ],
        ));
  }

  Widget buttonWidget() {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.grey,
      child: GridView.builder(
          itemCount: buttonList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
        setState(() {});
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
}
