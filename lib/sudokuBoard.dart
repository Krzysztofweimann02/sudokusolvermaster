import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';
import 'sudokuSolvingAlgorithm.dart';

class SudokuBoardWidget extends StatefulWidget {
  const SudokuBoardWidget({super.key});

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

  void fetchBoard() {
    setState(() {
      sudokuBoard = algorithm.getResolvedBoard();
    });
  }


  // Mechanical part that is solving the sudokuBoard
  bool hasSuccessSolution = false;
  bool hasMultipleSolutions = false; // flaga

  void runSolvingAlg() {
    if (algorithm.solve(sudokuBoard)) {
      if (algorithm.foundFirstSolution) {
        hasSuccessSolution = true;
        if (algorithm.holdBoard != null) {
          hasMultipleSolutions = true; // flaga - istnieje więcej niż jedno rozwiązanie
        }
      }

      fetchBoard();
      updateBoard();
    } else {
      hasSuccessSolution = false;
    }
  }

  void playSound(String sound) async {
    final player = AudioPlayer();
    if (enableSounds) await player.setVolume(volume); player.play(AssetSource(sound));
  }

  void checkIfMultipleSol() {
    if (hasSuccessSolution) {
      playSound("tada.mp3");
      if (hasMultipleSolutions) {;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sudoku rozwiązane!'),
              content: Text('Jest więcej niż jedno rozwiązań tego sudoku.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sudoku rozwiązane!'),
              content: Text(
                  'Jest to jedyne możliwe rozwiązanie tego sudoku.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Nie udało się rozwiązać tego sudoku"),
              content: Text(
                  'Wprowadzone sudoku nie posiada żadnego możliwego rozwiązania.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
      );
    } //
  }

  void tryToSolve() {
    playSound("click.mp3");
    setState(() {
      runSolvingAlg();
      checkIfMultipleSol();
    });
  }

  void resetBoard() {
    playSound("click.mp3");

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
      playSound("bin.mp3");
    });
  }

  bool isHover = false;
  int whichHovered = -1;

  Color setColor(int index) {
    late Color resultColor;

    if ((isHover && whichHovered != -1) && index == whichHovered) {
      resultColor = Colors.brown;
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


          ) ? resultColor = Colors.red : resultColor = Colors.orange;
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
                onEnter: (_) =>
                    setState(() {
                      isHover = true;
                      whichHovered = index;
                    }),
                onExit: (_) =>
                    setState(() {
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
                          late int previousValue;
                          late int row;
                          late int col;

                          row = getNumberAt(index);
                          col = getRowNumberAt(index);

                          previousValue = sudokuBoard[row][col];
                          try {
                            _userInputControllers
                                .elementAt(index)
                                .text = text;

                            int parsedValue = int.parse(text);

                            // Sprawdzenie, czy wartość jest pojedynczą cyfrą
                            if (parsedValue < 1 || parsedValue > 9) {
                              throw const FormatException(
                                  'Wprowadź liczbę od 1 do 9');
                            }

                            // Sprawdzenie, czy wprowadzona wartość jest bezpieczna w kontekście Sudoku
                            if (!algorithm.isSafe(
                                row, col, parsedValue, sudokuBoard)) {
                              throw const FormatException(
                                  'Nie z nami takie numery! W wierszu, kolumnie lub kwadracie 3x3 nie możesz wpisać dwóch takich samych liczb');
                            }
                            sudokuBoard[row][col] = parsedValue;
                          } catch (e) {
                            playSound("pop.mp3");
                            sudokuBoard[row][col] = previousValue;

                            String errorMessage = 'Błąd: ';
                            if (e is FormatException) {
                              errorMessage += e.message;
                              errorMessage += " (wprowadzona wartość nie jest prawidłowa)";
                            } else {
                              errorMessage += 'Nieprawidłowa wartość';
                            }

                            final snackBar = SnackBar(
                              content: Text(errorMessage),
                              duration: const Duration(seconds: 2),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                                snackBar);
                            if (sudokuBoard[row][col] == 0) {
                              Future.delayed(const Duration(seconds: 3), () {
                                _userInputControllers
                                    .elementAt(index)
                                    .text = '';
                              });
                            } else {
                              Future.delayed(const Duration(seconds: 3), () {
                                _userInputControllers
                                    .elementAt(index)
                                    .text = sudokuBoard[row][col] as String;
                              });
                            }
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
        // Buttons
        Padding(
          padding: const EdgeInsets.all(5),
          child: ElevatedButton(
            onPressed: tryToSolve,
            child: const Text('Rozwiąż'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: ElevatedButton(
            onPressed: resetBoard,
            child: const Text('Zresetuj'),
          ),
        ),
      ],
    );
  }
}