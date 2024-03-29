import 'package:tdd_intro/conways.dart';

// Any live cell with fewer than two live neighbours dies, as if caused by under-population.
// Any live cell with two or three live neighbours lives on to the next generation.
// Any live cell with more than three live neighbours dies, as if by overcrowding.
// Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
class ConwaysLifeAlgorithm implements LifeAlgorithm {
  @override
  bool isAlive(bool cell, int neighbours) {
    return cell && neighbours == 2 || neighbours == 3;
  }
}
