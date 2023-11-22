import 'package:audioplayers/audioplayers.dart';
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
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? Colors.black87 : Colors.white,
      appBar: AppBar(
          backgroundColor: darkMode ? Colors.red[800] : Colors.red[200],
          title: Text("Sudoku Solver",
              style: TextStyle(color: darkMode ? Colors.white : Colors.black))),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SudokuBoardWidget(),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Tryb ciemny: ",
                              style: TextStyle(
                                  color:
                                      darkMode ? Colors.white : Colors.black)),
                          Switch(
                            value: darkMode,
                            onChanged: (bool value) {
                              if (enableSounds) {
                                player.setVolume(volume);
                                player.play(AssetSource("click.mp3"));
                              }
                              setState(() {
                                darkMode = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Dźwiękowe: ",
                              style: TextStyle(
                                  color:
                                      darkMode ? Colors.white : Colors.black)),
                          Switch(
                            value: enableSounds,
                            onChanged: (bool value) {
                              if (enableSounds) {
                                player.setVolume(volume);
                                player.play(AssetSource("click.mp3"));
                              }
                              setState(() {
                                enableSounds = value;
                              });
                            },
                          ),
                        ],
                      ),
                      if (enableSounds)
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Text("Głośność: ",
                                  style: TextStyle(
                                      color: darkMode
                                          ? Colors.white
                                          : Colors.black)),
                              Slider(
                                label: volume.round().toString(),
                                value: volume,
                                onChanged: (double value) {
                                  setState(() {
                                    volume = value;
                                    player.setVolume(volume);

                                    if (volume == 0) {
                                      enableSounds = false;
                                      volume = 1;
                                    }
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
