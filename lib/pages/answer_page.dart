import 'package:flutter/material.dart';

class AnwserPage extends StatelessWidget {
  String answer;
  AnwserPage({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              answer,
              style: const TextStyle(fontSize: 30),
            ),
           FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Regresar'),
            ),
          ],
        ),
      ),
    );
  }
}
