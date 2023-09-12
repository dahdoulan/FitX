class ExerciseNotFoundException implements Exception {
  String text = 'No exercises found.';

  @override
  String toString() {
    return text;
  }
}
