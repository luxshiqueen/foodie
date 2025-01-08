import 'package:flutter/material.dart';
import 'views/Screens/title_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase here
  runApp(const Foodie());
}

class Foodie extends StatelessWidget {
  const Foodie({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
      ),
      home: const TitleScreen(),
    );
  }
}
