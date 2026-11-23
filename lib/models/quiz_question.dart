class QuizQuestion {
  const QuizQuestion({
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.category,
  });

  final String text;
  final List<String> options;
  final int correctIndex;
  final String category;
}