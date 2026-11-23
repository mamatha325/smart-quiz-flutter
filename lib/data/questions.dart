import '../models/quiz_question.dart';

const quizCategories = ['Flutter', 'Dart'];

const questions = [
  QuizQuestion(
    text: 'Which programming language is used to build Flutter apps?',
    options: ['Python', 'Dart', 'Ruby', 'Swift'],
    correctIndex: 1,
    category: 'Flutter',
  ),
  QuizQuestion(
    text: 'Which widget arranges its children vertically?',
    options: ['Row', 'Center', 'Stack', 'Column'],
    correctIndex: 3,
    category: 'Flutter',
  ),
  QuizQuestion(
    text: 'Which widget adds empty space around its child?',
    options: ['Padding', 'Icon', 'Text', 'Image'],
    correctIndex: 0,
    category: 'Flutter',
  ),
  QuizQuestion(
    text: 'Which widget displays a string on the screen?',
    options: ['Row', 'Text', 'Icon', 'Divider'],
    correctIndex: 1,
    category: 'Flutter',
  ),
  QuizQuestion(
    text: 'Which method tells Flutter that the state has changed?',
    options: ['dispose()', 'main()', 'runApp()', 'setState()'],
    correctIndex: 3,
    category: 'Flutter',
  ),
  QuizQuestion(
    text: 'Which Navigator method opens a new route?',
    options: ['push()', 'pop()', 'build()', 'dispose()'],
    correctIndex: 0,
    category: 'Flutter',
  ),
  QuizQuestion(
    text: 'Which widget displays a scrollable list of children?',
    options: ['Icon', 'Padding', 'Text', 'ListView'],
    correctIndex: 3,
    category: 'Flutter',
  ),
  QuizQuestion(
    text: 'Which widget is commonly placed at the root of a Flutter app?',
    options: ['MaterialApp', 'Card', 'Text', 'ListTile'],
    correctIndex: 0,
    category: 'Flutter',
  ),
  QuizQuestion(
    text: 'Which feature quickly updates a running Flutter app?',
    options: ['Cold start', 'Hot reload', 'Uninstall', 'APK signing'],
    correctIndex: 1,
    category: 'Flutter',
  ),
  QuizQuestion(
    text: 'Which widget is used when its displayed data can change?',
    options: [
      'Container',
      'StatelessWidget',
      'StatefulWidget',
      'SafeArea',
    ],
    correctIndex: 2,
    category: 'Flutter',
  ),
  QuizQuestion(
    text: 'Which function is the starting point of a Dart application?',
    options: ['build()', 'initState()', 'main()', 'setState()'],
    correctIndex: 2,
    category: 'Dart',
  ),
  QuizQuestion(
    text: 'What is the index of the first item in a Dart list?',
    options: ['1', '2', '0', '-1'],
    correctIndex: 2,
    category: 'Dart',
  ),
  QuizQuestion(
    text: 'Which Dart type stores either true or false?',
    options: ['int', 'bool', 'String', 'double'],
    correctIndex: 1,
    category: 'Dart',
  ),
  QuizQuestion(
    text: 'Which collection stores an ordered group of values?',
    options: ['List', 'bool', 'double', 'String'],
    correctIndex: 0,
    category: 'Dart',
  ),
  QuizQuestion(
    text: 'Which keyword creates a variable that can be assigned once?',
    options: ['while', 'final', 'if', 'class'],
    correctIndex: 1,
    category: 'Dart',
  ),
  QuizQuestion(
    text: 'Which symbol is used for string interpolation in Dart?',
    options: ['#', '@', r'$', '&'],
    correctIndex: 2,
    category: 'Dart',
  ),
  QuizQuestion(
    text: 'Which Dart type represents a value available later?',
    options: ['Future', 'Widget', 'ListTile', 'ThemeData'],
    correctIndex: 0,
    category: 'Dart',
  ),
  QuizQuestion(
    text: 'Which keyword defines a class in Dart?',
    options: ['return', 'import', 'class', 'void'],
    correctIndex: 2,
    category: 'Dart',
  ),
  QuizQuestion(
    text: 'Which operator checks whether two values are equal?',
    options: ['=', '==', '!=', '=>'],
    correctIndex: 1,
    category: 'Dart',
  ),
  QuizQuestion(
    text: 'Which method adds an item to a Dart list?',
    options: ['push()', 'insertText()', 'add()', 'open()'],
    correctIndex: 2,
    category: 'Dart',
  ),
];