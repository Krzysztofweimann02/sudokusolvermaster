import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sudokusolvermaster/SudokuView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
      child: ElevatedButton(
        child: const Text('Start!'),
          onPressed: () {
            player.play(AssetSource("click.mp3"));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SudokuView()),
            );
          },
        ),
      ),
    );
  }
}
