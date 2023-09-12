class InvalidInputException implements Exception {
  String text = 'Invalid input.';

  @override
  String toString() {
    return text;
  }
}
