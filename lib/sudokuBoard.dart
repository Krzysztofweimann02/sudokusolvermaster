import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'sudokuSolvingAlgorithm.dart';

class SudokuBoardWidget extends StatefulWidget {
  @override
  _SudokuBoardWidgetState createState() => _SudokuBoardWidgetState();
}

class _SudokuBoardWidgetState extends State<SudokuBoardWidget> {
  // creating 81 controllers for user input on board
  final List<TextEditingController> _userInputControllers = List.generate(
      81, (i) => TextEditingController());

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

  int getNumberAt(int index) {
    return index % 9;
  } // gets position of exact number in row
  int getRowNumberAt(int index) {
    return index ~/ 9;
  } // gets a row number from index

  int getDigitAt(int index) {
    int i = getNumberAt(index); // this will be used as row
    int j = getRowNumberAt(
        index); // this will be used as exact position in row 'i'

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

  void updateBoard() {
    setState(() {
      for (int i = 0; i < 81; i++) {
        _userInputControllers
            .elementAt(i)
            .text = getDigitAt(i).toString();
      }
    });
  }

  void tryToSolve() {
    setState(() {
      if (algorithm.solve(sudokuBoard)) {
        print("sudoku solved successfully!");
      }
      else {
        print("cannot solve that sudoku board");
      }
    });
  }

  void resetBoard() {
    setState(() {
      sudokuBoard = [
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

      for (int i = 0; i < 81; i++) {
        _userInputControllers
            .elementAt(i)
            .text = '';
      }
    });
  }

  void printBoard() {
    print(sudokuBoard);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 400,
      child: GridView.builder(
        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 9
        ),
        itemCount: 81,
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.all(2.0),
              padding: const EdgeInsets.all(3.0),
              color: ((getRowNumberAt(index) == 0) ||
                  (getRowNumberAt(index) == 1) ||
                  (getRowNumberAt(index) == 2) ||
                  (getRowNumberAt(index) == 6) ||
                  (getRowNumberAt(index) == 7) ||
                  (getRowNumberAt(index) == 8)) &&
                  ((getNumberAt(index) == 0) ||
                      (getNumberAt(index) == 1) ||
                      (getNumberAt(index) == 2) ||
                      (getNumberAt(index) == 6) ||
                      (getNumberAt(index) == 7) ||
                      (getNumberAt(index) == 8)) ||
                  ((getNumberAt(index) == 3) && (getRowNumberAt(index) == 3) ||
                      (getNumberAt(index) == 3) &&
                          (getRowNumberAt(index) == 4) ||
                      (getNumberAt(index) == 3) &&
                          (getRowNumberAt(index) == 5) ||
                      (getNumberAt(index) == 4) &&
                          (getRowNumberAt(index) == 3) ||
                      (getNumberAt(index) == 4) &&
                          (getRowNumberAt(index) == 4) ||
                      (getNumberAt(index) == 4) &&
                          (getRowNumberAt(index) == 5) ||
                      (getNumberAt(index) == 5) &&
                          (getRowNumberAt(index) == 3) ||
                      (getNumberAt(index) == 5) &&
                          (getRowNumberAt(index) == 4) ||
                      (getNumberAt(index) == 5) && (getRowNumberAt(index) == 5)


                  ) ? Colors.red : Colors.blue,
              child: Center(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  controller: _userInputControllers.elementAt(index),
                  onChanged: (text) {
                    _userInputControllers
                        .elementAt(index)
                        .text = text;
                    sudokuBoard[getNumberAt(index)][getRowNumberAt(index)] =
                        int.parse(text);
                  },
                ),
              )
          );
        },
      ),
    );
  }
}