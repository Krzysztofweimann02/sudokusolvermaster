import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sudokusolvermaster/main.dart';
import 'package:sudokusolvermaster/sudokuBoard.dart';

import 'sudokuSolvingAlgorithm.dart';

class SudokuView extends StatefulWidget {
  const SudokuView({super.key});

  @override
  State<SudokuView> createState() => _SudokuViewState();
}

class _SudokuViewState extends State<SudokuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? Colors.black87 : Colors.white,
      appBar: AppBar(
          backgroundColor: darkMode ? Colors.red[800] : Colors.red[200],
          title: Text("Sudoku Solver",
              style: TextStyle(color: darkMode ? Colors.white : Colors.black))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SudokuBoardWidget(),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Center(
                child: Row(
                  children: [
                    Text("Tryb ciemny: ",
                        style: TextStyle(
                            color: darkMode ? Colors.white : Colors.black)),
                    Switch(
                      value: darkMode,
                      onChanged: (bool value) {
                        setState(() {
                          darkMode = value;
                        });
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
