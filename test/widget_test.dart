import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_quiz/main.dart';
import 'package:smart_quiz/screens/quiz_screen.dart';

void main() {
  testWidgets('Welcome screen opens category selection', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Smart Quiz'), findsOneWidget);
    expect(find.text('Start Quiz'), findsOneWidget);

    await tester.tap(find.text('Start Quiz'));
    await tester.pumpAndSettle();

    expect(find.text('Choose Category'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Dart'), findsOneWidget);
  });

  testWidgets('Quiz calculates a perfect score and restarts', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      const MaterialApp(
        home: QuizScreen(
          category: 'Flutter',
          shuffleQuestions: false,
          secondsPerQuestion: 600,
        ),
      ),
    );

    const correctAnswers = [
      'Dart',
      'Column',
      'Padding',
      'Text',
      'setState()',
      'push()',
      'ListView',
      'MaterialApp',
      'Hot reload',
      'StatefulWidget',
    ];

    for (final answer in correctAnswers) {
      await tester.tap(find.text(answer));
      await tester.pump();

      final nextButton = find.byType(FilledButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle();
    }

    expect(find.text('Score: 10 / 10'), findsOneWidget);
    expect(find.text('Correct answers: 10'), findsOneWidget);
    expect(find.text('Incorrect answers: 0'), findsOneWidget);

    await tester.tap(find.text('Restart Quiz'));
    await tester.pumpAndSettle();

    expect(find.text('Question 1 of 10'), findsOneWidget);
  });
}