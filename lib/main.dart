import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tdd_intro/conways.dart';
import 'package:tdd_intro/conways_life_algorithm.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Conways - game of life'),
        ),
        body: Builder(
          builder: (context) {
            return MyHomePage(
              conways: ConwaysGoL(
                width: (MediaQuery.of(context).size.width / 10).floor(),
                height: (MediaQuery.of(context).size.height / 10).floor() - 8,
                algorithm: ConwaysLifeAlgorithm(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final ConwaysGoL conways;

  MyHomePage({Key key, this.conways}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(milliseconds: 150),
      (_) => {
        setState(() {
          widget.conways.evolve();
        })
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: makeGrid(widget.conways.getGrid()).toList(),
    );
  }

  Iterable<Widget> makeGrid(List<List<bool>> grid) sync* {
    for (var rowIndex = 0; rowIndex < grid.length; ++rowIndex) {
      yield Row(
        children: makeCell(grid[rowIndex]).toList(),
      );
    }
  }

  Iterable<Widget> makeCell(List<bool> grid) sync* {
    for (var cellIndex = 0; cellIndex < grid.length; ++cellIndex) {
      yield Container(
        height: 10,
        width: 10,
        color: grid[cellIndex] ? Colors.green : Colors.transparent,
      );
    }
  }
}
