class EmptyExerciseNameException implements Exception {
  String text = 'Exercise name is empty.';

  @override
  String toString() {
    return text;
  }
}
