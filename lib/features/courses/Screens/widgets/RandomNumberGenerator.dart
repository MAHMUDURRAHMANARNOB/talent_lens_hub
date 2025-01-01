import 'dart:math';

class RandomNumberGenerator {
  static String generateRandomNumber() {
    final random = Random();
    String randomNumber = '';

    for (int i = 0; i < 4; i++) {
      randomNumber += random.nextInt(10).toString();
    }

    return randomNumber;
  }
}
