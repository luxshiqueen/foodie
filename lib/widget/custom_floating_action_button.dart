import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomFloatingActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.orange,
      elevation: 6,
      child: const Icon(Icons.add, color: Color.fromARGB(255, 247, 243, 243)),
    );
  }
}
