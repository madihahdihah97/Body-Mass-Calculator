// import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final body = new Center(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
            child: Text("METRIC UNIT",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Fill in the blank.",
                 
                  
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)))),
          MyWidget(),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LBMC',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber[700],
            centerTitle: true,
            title: Text('LEAN BODY MASS CALCULATOR'),
          ),
          backgroundColor: Colors.pinkAccent[100],
          body: body),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _radioValue = 0;
  final TextEditingController _weightcontroller = new TextEditingController();
  final TextEditingController _heightcontroller = new TextEditingController();
  double weight = 0.0,
      height = 0.0,
      resultboer = 0.0,
      resultjames = 0.0,
      resulthume = 0.0;
  String lbmb, lbmj, lbmh;
  // bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: Row(
              children: [
                Text("GENDER: "),
                //Expanded(child: TextField())
                Radio(
                  value: 0,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                ),
                Text("MALE"),
                Radio(
                  value: 1,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                ),
                Text("FEMALE"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: Row(
              children: [
                Text("HEIGHT (cm): "),
                Expanded(
                    child: TextField(
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _heightcontroller,
                  // decoration: InputDecoration(
                  //   errorText: _validate ? 'Value Can\'t Be Empty' : null,
                  // ),
                ))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: Row(
              children: [
                Text("WEIGHT (kg): "),
                Expanded(
                    child: TextField(
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _weightcontroller,
                  // decoration: InputDecoration(
                  //   errorText: _validate ? 'Value Can\'t Be Empty' : null,
                  // ),
                ))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  child: Text("CALCULATE",
                  style: TextStyle(color: Colors.black, fontSize: 18,),
                  ),
                  onPressed: _calculate,
                  color: Colors.amber[700],
                ),
                SizedBox(
                  width: 10,
                ),
                //Spacer(),
                FlatButton(
                  child: Text("CLEAR",
                  style: TextStyle(color: Colors.black, fontSize: 18.0),),
                  onPressed: _clear,
                  color: Colors.amber[700],
                )
              ],
            ),
          ),
          Text("RESULT:"),
          // Text("Boer: $lbmb"),
          // Text("James: $lbmj"),
          // Text("Hume: $lbmh"),
          Container(
          child: DataTable (
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Formula',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Lean Body Mass',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ],
            rows: <DataRow>[
              DataRow(cells: <DataCell>[
                DataCell(Text("Boer")),
                DataCell(Text("$lbmb")),
              ],),
              DataRow(cells: <DataCell>[
                DataCell(Text("James")),
                DataCell(Text("$lbmj")),
              ],),
              DataRow(cells: <DataCell>[
                DataCell(Text("Hume")),
                DataCell(Text("$lbmh")),
              ],),
            ],
          ),)
        ],
      ),
    );
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  void _calculate() {
    setState(() {
      if (_weightcontroller.text.isEmpty && _heightcontroller.text.isNotEmpty) {
        weight = 0;
      } else if (_heightcontroller.text.isEmpty &&
          _weightcontroller.text.isNotEmpty) {
        height = 0;
      } else {
        // _heightcontroller.text.isEmpty ? _validate = true : _validate = false;
        // _weightcontroller.text.isEmpty ? _validate = true : _validate = false;
        weight = double.parse(_weightcontroller.text);
        height = double.parse(_heightcontroller.text);
      }

      // try{
      if (_radioValue == 0) {
        resultboer = (0.407 * weight) + (0.267 * height) - 19.2;
        lbmb = format(resultboer);
        resultjames = (1.1 * weight) - (128 * (pow((weight / height), 2)));
        lbmj = format(resultjames);
        resulthume = (0.32810 * weight) + (0.33929 * height) - 29.5336;
        lbmh = format(resulthume);
      } else if (_radioValue == 1) {
        resultboer = (0.252 * weight) + (0.473 * height) - 48.3;
        lbmb = format(resultboer);
        resultjames = (1.07 * weight) - (148 * (pow((weight / height), 2)));
        lbmj = format(resultjames);
        resulthume = (0.29569 * weight) + (0.41813 * height) - 43.2933;
        lbmh = format(resulthume);
      }
    }
        // catch (ex){
        //   Text("error");
        // }
        );
  }

  void _clear() {
    setState(() {
      _weightcontroller.clear();
      _heightcontroller.clear();
      lbmb = "null";
      lbmh = "null";
      lbmj = "null";

    });
  }

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }
}
