import 'package:flutter/material.dart';
import 'matching_data.dart';

class MatchingGameScreen extends StatelessWidget {
  const MatchingGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final terms = matchingItems.map((e) => e.keys.first).toList();
    final definitions = matchingItems.map((e) => e.values.first).toList()..shuffle();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Matching Game'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Match the terms with their correct definitions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: terms.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(terms[index]),
                      subtitle: Text(definitions[index]), // not interactive yet
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
