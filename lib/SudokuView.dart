import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Sudoku Solver")
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SudokuBoardWidget(),
            ],
          ),
        ),
    );
  }
}
