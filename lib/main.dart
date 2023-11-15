import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'sudokuSolvingAlgorithm.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudoku Solver',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // creating 81 controllers for user input on board
  final List<TextEditingController> _userInputControllers = List.generate(81, (i) => TextEditingController());

  List<List<int>> sudokuBoard = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
  ];

  SudokuSolvingAlgorithm algorithm = SudokuSolvingAlgorithm();

  int getNumberAt(int index) { return index % 9; }        // gets position of exact number in row
  int getRowNumberAt(int index) { return index ~/ 9; }    // gets a row number from index

  int getDigitAt(int index) {
    int i = getNumberAt(index);   // this will be used as row
    int j = getRowNumberAt(index); // this will be used as exact position in row 'i'

    List<int> row = sudokuBoard.elementAt(i);
    int digit = row.elementAt(j);

    return digit;
  }

  // displays exact position of digit in row and the row of that digit
  String getCellText(int index) {
    int number = getNumberAt(index);
    int row = getRowNumberAt(index);

    return '${number.toString()}, ${row.toString()}';
  }

  void update() {
    setState(() {
      for (int i = 0; i < 81; i++) {
        _userInputControllers.elementAt(i).text = getDigitAt(i).toString();
      }
    });
  }

  void tryToSolve() {
    setState(() {
      if (algorithm.solve(sudokuBoard)) { print("sudoku solved successfully!"); }
      else { print("cannot solve that sudoku board"); }
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      ),
    );
  }
}
