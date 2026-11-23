import 'package:flutter/material.dart';

import '../data/questions.dart';
import 'quiz_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final currentDarkMode =
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Category'),
        actions: [
          IconButton(
            tooltip:
                currentDarkMode ? 'Use light mode' : 'Use dark mode',
            onPressed: () {
              onThemeChanged(!currentDarkMode);
            },
            icon: Icon(
              currentDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Icon(
                  Icons.category_outlined,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Select a quiz category',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Each category contains 10 questions. '
                  'The questions are randomized every time.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                for (final category in quizCategories)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Card(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: CircleAvatar(
                          child: Icon(
                            category == 'Flutter'
                                ? Icons.flutter_dash
                                : Icons.code,
                          ),
                        ),
                        title: Text(
                          category,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        subtitle: const Text(
                          '10 questions • 60 seconds each',
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => QuizScreen(
                                category: category,
                              ),
                            ),
                          );
                        },
                      ),
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