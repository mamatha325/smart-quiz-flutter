import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/category_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final preferences = await SharedPreferences.getInstance();
    final savedDarkMode = preferences.getBool('dark_mode') ?? false;

    if (!mounted) {
      return;
    }

    setState(() {
      _isDarkMode = savedDarkMode;
    });
  }

  void _changeTheme(bool useDarkMode) {
    setState(() {
      _isDarkMode = useDarkMode;
    });

    unawaited(_saveThemeMode(useDarkMode));
  }

  Future<void> _saveThemeMode(bool useDarkMode) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('dark_mode', useDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Quiz',
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: WelcomeScreen(
        isDarkMode: _isDarkMode,
        onThemeChanged: _changeTheme,
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: isDarkMode ? 'Use light mode' : 'Use dark mode',
            onPressed: () {
              onThemeChanged(!isDarkMode);
            },
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
        ],
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
                  Container(
  width: 112,
  height: 112,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.tertiary,
      ],
    ),
    borderRadius: BorderRadius.circular(32),
    boxShadow: [
      BoxShadow(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
        blurRadius: 24,
        offset: const Offset(0, 12),
      ),
    ],
  ),
  child: const Stack(
    alignment: Alignment.center,
    children: [
      Icon(
        Icons.code_rounded,
        size: 64,
        color: Colors.white,
      ),
      Positioned(
        top: 15,
        right: 15,
        child: Icon(
          Icons.check_circle_rounded,
          size: 22,
          color: Colors.amberAccent,
        ),
      ),
    ],
  ),
),
                  const SizedBox(height: 20),
                  Text(
                    'Smart Quiz',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Choose a category and answer 10 randomized '
                    'multiple-choice questions before time runs out.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => CategoryScreen(
                            isDarkMode: isDarkMode,
                            onThemeChanged: onThemeChanged,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start Quiz'),
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