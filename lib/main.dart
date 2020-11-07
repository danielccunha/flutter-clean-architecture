import 'package:flutter_clean_architecture/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:flutter_clean_architecture/injection.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Environment.prod);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      home: NumberTriviaPage(),
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        accentColor: Colors.green.shade600,
      ),
    );
  }
}
