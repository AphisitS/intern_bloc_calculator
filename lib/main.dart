import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CALCULATOR',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyCalculatorPage(title: 'CALCULATOR'),
    );
  }
}

class MyCalculatorPage extends StatefulWidget {
  MyCalculatorPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyCalculatorPageState createState() => _MyCalculatorPageState();
}

class _MyCalculatorPageState extends State<MyCalculatorPage> {
  String answer;
  String answerTemp;
  String inputFull;
  String operator;
  bool calculateMode;

  @override
  void initState() {
    answer = "0";
    operator = "";
    answerTemp = "";
    inputFull = "";
    calculateMode = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: AppBar(
          toolbarHeight: 300,
          backgroundColor: Color(0xffdbdbdb),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('  '),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(widget.title,
                    style: TextStyle(fontSize: 30, color: Colors.black)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(

                      padding: const EdgeInsets.all(10),
                      child: Row(children: [
                    IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: () {}),
                    Text("Standard",
                        style: TextStyle(fontSize: 40, color: Colors.black,fontWeight: FontWeight.bold)),
                    IconButton(
                        icon: Icon(Icons.screen_share_outlined, color: Colors.black,size: 30,),
                        onPressed: () {}),
                  ])),
                  IconButton(
                      icon: Icon(Icons.history, color: Colors.black,size: 30,),
                      onPressed: () {}),
                ],
              )
            ],
          ),
          elevation: 1,
        ),
      ),
      body: Container(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          buildAnswerWidget(),
          buildNumPadWidget(),
        ],
      )),
    );
  }

  Widget buildAnswerWidget() {
    return Expanded(
        child: Container(
            padding: EdgeInsets.all(16),
            color: Color(0xffdbdbdb),
            child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(inputFull + " " + operator,
                          style: TextStyle(fontSize: 18)),
                      Text(answer,
                          style: TextStyle(
                              fontSize: 48, fontWeight: FontWeight.bold))
                    ]))));
  }

  Widget buildNumPadWidget() {
    return Container(
        color: Color(0xffdbdbdb),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                Widget>[
              Text('MC',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
              Text('MR',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
              Text('M+',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              Text('M-',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              Text('MS',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              Text('M-',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
            ]),
            Row(children: <Widget>[
              buildNumberButton("%", numberButton: false, onTap: () {
                clearAnswer();
              }),
              buildNumberButton("CE", numberButton: false, onTap: () {
                clearAnswer();
              }),
              buildNumberButton("C", numberButton: false, onTap: () {
                clearAll();
              }),
              buildNumberButton("⌫", numberButton: false, onTap: () {
                removeAnswerLast();
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("1/x", numberButton: false, onTap: () {
                clearAnswer();
              }),
              buildNumberButton("X^2", numberButton: false, onTap: () {
                clearAll();
              }),
              buildNumberButton("2√x", numberButton: false, onTap: () {
                removeAnswerLast();
              }),
              buildNumberButton("÷", numberButton: false, onTap: () {
                addOperatorToAnswer("÷");
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("7", onTap: () {
                addNumberToAnswer(7);
              }),
              buildNumberButton("8", onTap: () {
                addNumberToAnswer(8);
              }),
              buildNumberButton("9", onTap: () {
                addNumberToAnswer(9);
              }),
              buildNumberButton("×", numberButton: false, onTap: () {
                addOperatorToAnswer("×");
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("4", onTap: () {
                addNumberToAnswer(4);
              }),
              buildNumberButton("5", onTap: () {
                addNumberToAnswer(5);
              }),
              buildNumberButton("6", onTap: () {
                addNumberToAnswer(6);
              }),
              buildNumberButton("−", numberButton: false, onTap: () {
                addOperatorToAnswer("-");
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("1", onTap: () {
                addNumberToAnswer(1);
              }),
              buildNumberButton("2", onTap: () {
                addNumberToAnswer(2);
              }),
              buildNumberButton("3", onTap: () {
                addNumberToAnswer(3);
              }),
              buildNumberButton("+", numberButton: false, onTap: () {
                addOperatorToAnswer("+");
              }),
            ]),
            Row(children: <Widget>[
              buildNumberButton("±",onTap: () {
                toggleNegative();
              }),
              buildNumberButton("0", onTap: () {
                addNumberToAnswer(0);
              }),
              buildNumberButton(".",  onTap: () {
                addDotToAnswer();
              }),
              buildNumberButton("=", numberButton: false, onTap: () {
                calculate();
              }),
            ]),
          ],
        ));
  }

  void toggleNegative() {
    setState(() {
      if (answer.contains("-")) {
        answer = answer.replaceAll("-", "");
      } else {
        answer = "-" + answer;
      }
    });
  }

  void clearAnswer() {
    setState(() {
      answer = "0";
    });
  }

  void clearAll() {
    setState(() {
      answer = "0";
      inputFull = "";
      calculateMode = false;
      operator = "";
    });
  }

  void calculate() {
    setState(() {
      if (calculateMode) {
        bool decimalMode = false;
        double value = 0;
        if (answer.contains(".") || answerTemp.contains(".")) {
          decimalMode = true;
        }

        if (operator == "+") {
          value = (double.parse(answerTemp) + double.parse(answer));
        } else if (operator == "-") {
          value = (double.parse(answerTemp) - double.parse(answer));
        } else if (operator == "×") {
          value = (double.parse(answerTemp) * double.parse(answer));
        } else if (operator == "÷") {
          value = (double.parse(answerTemp) / double.parse(answer));
        }

        if (!decimalMode) {
          answer = value.toInt().toString();
        } else {
          answer = value.toString();
        }

        calculateMode = false;
        operator = "";
        answerTemp = "";
        inputFull = "";
      }
    });
  }

  void addOperatorToAnswer(String op) {
    setState(() {
      if (answer != "0" && !calculateMode) {
        calculateMode = true;
        answerTemp = answer;
        inputFull += operator + " " + answerTemp;
        operator = op;
        answer = "0";
      } else if (calculateMode) {
        if (answer.isNotEmpty) {
          calculate();
          answerTemp = answer;
          inputFull = "";
          operator = "";
        } else {
          operator = op;
        }
      }
    });
  }

  void addDotToAnswer() {
    setState(() {
      if (!answer.contains(".")) {
        answer = answer + ".";
      }
    });
  }

  void addNumberToAnswer(int number) {
    setState(() {
      if (number == 0 && answer == "0") {
        // Not do anything.
      } else if (number != 0 && answer == "0") {
        answer = number.toString();
      } else {
        answer += number.toString();
      }
    });
  }

  void removeAnswerLast() {
    if (answer == "0") {
      // Not do anything.
    } else {
      setState(() {
        if (answer.length > 1) {
          answer = answer.substring(0, answer.length - 1);
          if (answer.length == 1 && (answer == "." || answer == "-")) {
            answer = "0";
          }
        } else {
          answer = "0";
        }
      });
    }
  }

  Widget buildNumberButton(String str,
      {@required Function() onTap, bool numberButton = true}) {
    Widget widget;
    if (numberButton) {
      widget = Container(
          margin: EdgeInsets.all(3),
          child: Material(
              color: Colors.white,
              child: InkWell(
                  onTap: onTap,
                  splashColor: Colors.blue,
                  child: Container(
                      height: 100,
                      child: Center(
                          child: Text(str,
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold)))))));
    } else {
      widget = Container(
          margin: EdgeInsets.all(3),
          child: Material(
              color: (str == '=')  ? Colors.redAccent : Color(0xffecf0f1),
              child: InkWell(
                  onTap: onTap,
                  splashColor: Colors.blue,
                  child: Container(
                      height: 100,
                      child: Center(
                          child: Text(str, style: TextStyle(fontSize: 28)))))));
    }

    return Expanded(child: widget);
  }
}
