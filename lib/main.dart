import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sudokusolvermaster/SudokuView.dart';

bool darkMode = false;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudoku Solver',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sudoku Solver'),
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
  final player = AudioPlayer();

  @override
  void dispose() {
    // TODO: implement dispose
    player.stop();
  }

  @override
  void didPop() {
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? Colors.black87 : Colors.white,
      appBar: AppBar(
        backgroundColor: darkMode ? Colors.red[800] : Colors.red[200],
        title: Text(widget.title, style: TextStyle(
            color: darkMode ? Colors.white : Colors.black)),
      ),
      body: Center(
      child: ElevatedButton(
        child: const Text('Start!'),
          onPressed: () async {
             await player.play(AssetSource("click.mp3"));
             await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SudokuView()),
            );
             setState(() {

             });
          }
        ),
      ),
    );
  }
}
