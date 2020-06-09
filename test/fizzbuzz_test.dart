import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_intro/fizzbuzz.dart';

void main() {
  group(FizzBuzz, () {
    group('returns Fizz for multiples of 3', () {
      [3, 6, 9, 12].forEach((value) {
        test('for $value', () {
          var result = FizzBuzz.execute(value);
          expect(result, 'Fizz');
        });
      });
    });

    group('returns Buzz for multiples of 5', () {
      [5, 10, 20].forEach((value) {
        test('for $value', () {
          var result = FizzBuzz.execute(value);
          expect(result, 'Buzz');
        });
      });
    });
    group('returns FizzBuzz for multiples of 3 and 5', () {
      [15, 30].forEach((value) {
        test('for $value', () {
          var result = FizzBuzz.execute(value);
          expect(result, 'FizzBuzz');
        });
      });
    });

    group('returns number for non mulitple of 3 or 5', () {
      [1, 2, 4, 7, 8, 11].forEach((value) {
        test('for $value', () {
          var result = FizzBuzz.execute(value);
          expect(result, value.toString());
        });
      });
    });
  });
}
