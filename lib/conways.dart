import 'dart:math';

abstract class LifeAlgorithm {
  bool isAlive(bool cell, int neighbours);
}

class RandomLifeAlgorithm implements LifeAlgorithm {
  @override
  bool isAlive(bool cell, int neighbours) => Random().nextInt(3) == 1;
}

class ConwaysGoL {
  List<List<bool>> _grid;
  int width;
  int height;
  List<List<bool>> getGrid() => _grid;
  final LifeAlgorithm algorithm;

  ConwaysGoL({this.width, this.height, this.algorithm}) {
    _grid = makeGrid(RandomLifeAlgorithm());
  }

  List<List<bool>> makeGrid(LifeAlgorithm algorithm) {
    return List<List<bool>>.generate(
      height,
      (i) => List<bool>.generate(
        width,
        (j) => algorithm.isAlive(
          _grid == null ? false : _grid[i][j],
          _getNeighbours(i, j),
        ),
      ),
    );
  }

  int _getNeighbours(int x, int y) {
    if (_grid == null) return 0;
    var numOfAliveNeighbors = 0;

    for (var i = x - 1; i < x + 2; i++) {
      for (var j = y - 1; j < y + 2; j++) {
        if ((i < 0 || j < 0) || (i >= height || j >= width)) continue;
        if ((i == x) && (j == y)) continue;
        if (_grid[i][j]) numOfAliveNeighbors++;
      }
    }
    return numOfAliveNeighbors;
  }

  void evolve() {
    _grid = makeGrid(algorithm);
  }
}
