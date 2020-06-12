import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_intro/conways_life_algorithm.dart';

const Matcher toBeDead = isFalse;
const Matcher toBeAlive = isTrue;

void main() {
  group(ConwaysLifeAlgorithm, () {
    group('a live cell with less than 2 neighbours dies', () {
      [0, 1].forEach((value) {
        test('$value neighbours', () {
          var algorithm = new ConwaysLifeAlgorithm();

          var cell = algorithm.isAlive(true, value);

          expect(cell, toBeDead);
        });
      });
    });
    group('a live cell with 2 or 3 neighbours lives', () {
      [2, 3].forEach((value) {
        test('$value neighbours', () {
          var algorithm = new ConwaysLifeAlgorithm();

          var cell = algorithm.isAlive(true, value);

          expect(cell, toBeAlive);
        });
      });
    });
    group('a live cell with more than 3 neighbours dies', () {
      [4, 5, 6, 7, 8].forEach((value) {
        test('$value neighbours', () {
          var algorithm = new ConwaysLifeAlgorithm();

          var cell = algorithm.isAlive(true, value);

          expect(cell, toBeDead);
        });
      });
    });

    test('a dead cell with 3 neighbours lives', () {
      var algorithm = new ConwaysLifeAlgorithm();

      var cell = algorithm.isAlive(false, 3);

      expect(cell, toBeAlive);
    });

    group('a dead cell neighbours different than 3 stays dead', () {
      [0, 1, 2, 4, 5, 6, 7, 8].forEach((value) {
        test('$value neighbours', () {
          var algorithm = new ConwaysLifeAlgorithm();

          var cell = algorithm.isAlive(false, value);

          expect(cell, toBeDead);
        });
      });
    });
  });
}
