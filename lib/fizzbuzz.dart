class FizzBuzz {
  static String execute(int value) {
    var result = '';
    if (value % 3 == 0) result += 'Fizz';
    if (value % 5 == 0) result += 'Buzz';

    return result != '' ? result : value.toString();
  }
}
