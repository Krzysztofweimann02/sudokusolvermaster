import 'package:audioplayers/audioplayers.dart';

class SudokuSolvingAlgorithm {
  late List<List<int>> holdBoard;

  bool solve(List<List<int>> board) {
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (board[row][col] == 0) {
          for (int num = 1; num <= 9; num++) {
            if (isSafe(row, col, num, board)) {
              board[row][col] = num;
              if (solve(board)) {
                holdBoard = board;
                return true;
              }
              board[row][col] = 0;
            }
          }
          return false;
        }
      }
    }
    return true;
  }

  List<List<int>> getResolvedBoard() { return holdBoard; }

  bool isSafe(int row, int col, int num, List<List<int>> board) {
    for (int i = 0; i < 9; i++) {
      if (board[row][i] == num || board[i][col] == num) {
        return false;
      }
    }

    int startRow = (row ~/ 3) * 3;
    int startCol = (col ~/ 3) * 3;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[startRow + i][startCol + j] == num) {
          return false;
        }
      }
    }

    return true;
  }
}
