import 'dart:async';
import 'package:flutter/material.dart';
import 'quiz_question.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final List<QuizQuestion> questions;

  const QuizScreen({super.key, required this.questions});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int score = 0;
  int timeLeft = 15;// mabadiriko ya muda
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timeLeft = 15;// mabadiriko ya muda
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft == 0) {
        nextQuestion();
      } else {
        setState(() => timeLeft--);
      }
    });
  }

  void nextQuestion() {
    timer?.cancel();
    if (currentQuestion < widget.questions.length - 1) {
      setState(() {
        currentQuestion++;
        startTimer();
      });
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ResultScreen(score: score),
        ),
      );
    }
  }

  void checkAnswer(int selectedIndex) {
    if (selectedIndex == widget.questions[currentQuestion].correctIndex) {
      score++;
    }
    nextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestion];
    final isTrueFalse = question.options.length == 2 &&
        question.options.contains("True") &&
        question.options.contains("False");

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Time Left: $timeLeft",
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
                const SizedBox(height: 20),
                Text(
                  question.question,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ...(isTrueFalse
                    ? question.options.map((text) {
                  int index = question.options.indexOf(text);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ElevatedButton(
                      onPressed: () => checkAnswer(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(text),
                    ),
                  );
                }).toList()
                    : List.generate(question.options.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ElevatedButton(
                      onPressed: () => checkAnswer(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(question.options[index]),
                    ),
                  );
                })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
