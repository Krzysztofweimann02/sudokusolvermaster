class SudokuSolvingAlgorithm {
  late List<List<int>> sudokuBoard;

  SudokuSolvingAlgorithm(List<List<int>> board) {
    sudokuBoard = board;
  }

  bool solve() {
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (sudokuBoard[row][col] == 0) {
          for (int num = 1; num <= 9; num++) {
            if (isSafe(row, col, num)) {
              sudokuBoard[row][col] = num;
              if (solve()) {
                return true;
              }
              sudokuBoard[row][col] = 0;
            }
          }
          return false;
        }
      }
    }
    return true;
  }

  bool isSafe(int row, int col, int num) {
    for (int i = 0; i < 9; i++) {
      if (sudokuBoard[row][i] == num || sudokuBoard[i][col] == num) {
        return false;
      }
    }

    int startRow = (row ~/ 3) * 3;
    int startCol = (col ~/ 3) * 3;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (sudokuBoard[startRow + i][startCol + j] == num) {
          return false;
        }
      }
    }

    return true;
  }
}
