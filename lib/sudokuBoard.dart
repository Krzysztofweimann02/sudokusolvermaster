import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'sudokuSolvingAlgorithm.dart';

class SudokuBoardWidget extends StatefulWidget {
  const SudokuBoardWidget({super.key});

  @override
  _SudokuBoardWidgetState createState() => _SudokuBoardWidgetState();
}

class _SudokuBoardWidgetState extends State<SudokuBoardWidget> {
  final player = AudioPlayer();
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

  void fetchBoard() {
    setState(() {
      sudokuBoard = algorithm.getResolvedBoard();
    });

  }

  void tryToSolve() {
    setState(() {
      if (algorithm.solve(sudokuBoard)) {
        resultText = "sudoku solved successfully!";
      }
      else {
        resultText = "cannot solve that sudoku board";
      }
      fetchBoard();
      updateBoard();
    });
  }

  void resetBoard() {
    setState(() {
      player.play(AssetSource("error.wav"));
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

      resultText = '';

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

  String resultText = '';
  bool isHover = false;
  int whichHovered = -1;

  Color setColor(int index) {
    late Color resultColor;

    if ((isHover && whichHovered != -1) && index == whichHovered) {
      resultColor = Colors.amber;
    } else {
    ((getRowNumberAt(index) == 0) ||
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
        ((getNumberAt(index) == 3) &&
            (getRowNumberAt(index) == 3) ||
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
            (getNumberAt(index) == 5) &&
                (getRowNumberAt(index) == 5)


        ) ? resultColor = Colors.red : resultColor = Colors.blue;
    }

    return resultColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 400,
          height: 400,
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 9
            ),
            itemCount: 81,
            itemBuilder: (context, index) {
              return MouseRegion(
                onEnter: (_) => setState(() {
                  isHover = true;
                  whichHovered = index;
                }),
                onExit: (_) => setState(() {
                  isHover = false;
                  whichHovered = -1;
                }),
                child: Container(
                  margin: const EdgeInsets.all(2.0),
                  padding: const EdgeInsets.all(3.0),
                  color: setColor(index),
                  child: Center(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      controller: _userInputControllers.elementAt(index),
                      onChanged: (text) {
                        try {
                          _userInputControllers.elementAt(index).text = text;
                          int parsedValue = int.parse(text);

                          // Sprawdzenie, czy wartość jest pojedynczą cyfrą
                          if (parsedValue < 1 || parsedValue > 9) {
                            throw const FormatException('Wprowadź liczbę od 1 do 9');
                          }

                          // Aktualizacja planszy tylko dla prawidłowych wartości
                          sudokuBoard[getNumberAt(index)][getRowNumberAt(index)] = parsedValue;
                        } catch (e) {
                          final snackBar = const SnackBar(
                            content: Text('Błąd: Wprowadź liczbę od 1 do 9'),
                            duration: Duration(seconds: 2),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Future.delayed(const Duration(seconds: 2), () {
                            _userInputControllers.elementAt(index).text = '';
                          });
                        }
                      },
                    ),
                  )
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Text(resultText),

        // Buttons
        Padding(
          padding: const EdgeInsets.all(5),
          child: ElevatedButton(
            onPressed: tryToSolve,
            child: const Text('Solve'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: ElevatedButton(
            onPressed: resetBoard,
            child: const Text('Reset'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: ElevatedButton(
            onPressed: printBoard,
            child: const Text("DEBUG: PrintBoard()"),
          ),
        ),
      ],
    );
  }
}