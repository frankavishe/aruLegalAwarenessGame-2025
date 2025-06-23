import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int score;

  const ResultScreen({super.key, required this.score});

  String getRemarks() {
    if (score >= 18) {
      return "Excellent performance!";
    } else if (score >= 14) {
      return "Good job! Keep it up!";
    } else if (score >= 10) {
      return "Fair attempt. You can do better.";
    } else {
      return "Needs improvement. Try again!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("QUIZ COMPLETED", style: TextStyle(fontSize: 26, color: Colors.white)),
              const SizedBox(height: 30),
              Text("Your Score: $score / 20", style: const TextStyle(fontSize: 22, color: Colors.white)),
              const SizedBox(height: 20),
              Text(getRemarks(), style: const TextStyle(fontSize: 20, color: Colors.white)),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: const Text("Back", style: TextStyle(color: Colors.deepPurple)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Replace with your actual URL
                  print("Download By-Law Here button pressed.");
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: const Text("Download By-Law Here", style: TextStyle(color: Colors.deepPurple)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
