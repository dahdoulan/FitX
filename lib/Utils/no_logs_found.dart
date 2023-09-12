class NoLogsFoundException implements Exception {
  String text = 'No logs were found.';

  @override
  String toString() {
    return text;
  }
}
