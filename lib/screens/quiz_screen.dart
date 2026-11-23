import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/questions.dart';
import '../models/quiz_question.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    super.key,
    this.category = 'Flutter',
    this.shuffleQuestions = true,
  this.secondsPerQuestion = 60,
  });

  final String category;
  final bool shuffleQuestions;
  final int secondsPerQuestion;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final List<QuizQuestion> _quizQuestions;

  Timer? _questionTimer;
  int _questionIndex = 0;
  int _score = 0;
 int _secondsLeft = 60;
  int? _selectedIndex;
  bool _isAdvancing = false;

  @override
  void initState() {
    super.initState();

    _quizQuestions = questions
        .where((question) => question.category == widget.category)
        .toList();

    if (widget.shuffleQuestions) {
      _quizQuestions.shuffle();
    }

    _secondsLeft = widget.secondsPerQuestion;
    _startTimer();
  }

  void _startTimer() {
    _questionTimer?.cancel();
    _secondsLeft = widget.secondsPerQuestion;

    _questionTimer = Timer.periodic(
      const Duration(seconds: 1),
      _handleTimerTick,
    );
  }

  void _handleTimerTick(Timer timer) {
    if (!mounted) {
      timer.cancel();
      return;
    }

    if (_secondsLeft > 1) {
      setState(() {
        _secondsLeft--;
      });
      return;
    }

    timer.cancel();

    setState(() {
      _secondsLeft = 0;
    });

    _completeQuestion(timedOut: true);
  }

  void _submitAnswer() {
    _completeQuestion(timedOut: false);
  }

  void _completeQuestion({required bool timedOut}) {
    if (_isAdvancing) {
      return;
    }

    final selectedIndex = _selectedIndex;

    if (!timedOut && selectedIndex == null) {
      return;
    }

    _isAdvancing = true;
    _questionTimer?.cancel();

    final currentQuestion = _quizQuestions[_questionIndex];
    final answeredCorrectly =
        !timedOut && selectedIndex == currentQuestion.correctIndex;
    final updatedScore = answeredCorrectly ? _score + 1 : _score;
    final isLastQuestion =
        _questionIndex == _quizQuestions.length - 1;

    if (isLastQuestion) {
      setState(() {
        _score = updatedScore;
      });

      _openResults(updatedScore);
      return;
    }

    setState(() {
      _score = updatedScore;
      _questionIndex++;
      _selectedIndex = null;
      _isAdvancing = false;
    });

    _startTimer();
  }

  Future<void> _openResults(int finalScore) async {
    final preferences = await SharedPreferences.getInstance();
    final storageKey = 'high_score_${widget.category}';
    final previousHighScore = preferences.getInt(storageKey) ?? 0;
    final highScore =
        finalScore > previousHighScore ? finalScore : previousHighScore;

    if (finalScore > previousHighScore) {
      await preferences.setInt(storageKey, finalScore);
    }

    if (!mounted) {
      return;
    }

    Navigator.of(context).pushReplacement<void, void>(
      MaterialPageRoute<void>(
        builder: (_) => ResultsScreen(
          score: finalScore,
          total: _quizQuestions.length,
          highScore: highScore,
          category: widget.category,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _questionTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = _quizQuestions[_questionIndex];
    final questionNumber = _questionIndex + 1;
    final total = _quizQuestions.length;
    final timerColor = _secondsLeft <= 10
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Quiz'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: ListView(
              key: ValueKey(_questionIndex),
              padding: const EdgeInsets.all(24),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Question $questionNumber of $total',
                      ),
                    ),
                    Icon(
                      Icons.timer_outlined,
                      color: timerColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$_secondsLeft s',
                      style: TextStyle(
                        color: timerColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: questionNumber / total,
                ),
                const SizedBox(height: 24),
                Text(
                  question.text,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                for (var index = 0;
                    index < question.options.length;
                    index++)
                  Card(
                    child: ListTile(
                      selected: _selectedIndex == index,
                      leading: Icon(
                        _selectedIndex == index
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                      ),
                      title: Text(question.options[index]),
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed:
                      _selectedIndex == null ? null : _submitAnswer,
                  child: Text(
                    questionNumber == total
                        ? 'See Results'
                        : 'Next Question',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.score,
    required this.total,
    required this.highScore,
    required this.category,
  });

  final int score;
  final int total;
  final int highScore;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.emoji_events_outlined,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '$category Quiz',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Score: $score / $total',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 12),
                  Text('Correct answers: $score'),
                  Text('Incorrect answers: ${total - score}'),
                  const SizedBox(height: 8),
                  Text(
                    'High score: $highScore / $total',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement<void, void>(
                        MaterialPageRoute<void>(
                          builder: (_) => QuizScreen(
                            category: category,
                          ),
                        ),
                      );
                    },
                    child: const Text('Restart Quiz'),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Choose Another Category'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}