class EmptyExerciseException implements Exception {
  String text = 'One or more exercises are empty.';

  @override
  String toString() {
    return text;
  }
}
