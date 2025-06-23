import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'quiz_screen.dart';
import 'quiz_data.dart';         // Multiple Choice (50 randomized questions)
import 'quiz_data2.dart';       // True or False
import 'matching_game_screen.dart'; // Matching Game

class GameChoiceScreen extends StatelessWidget {
  const GameChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A237E), Color(0xFF311B92)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                Text(
                  '🎮 GAME MODES',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.pressStart2p(
                    color: Colors.yellowAccent,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 50),

                // Multiple Choice
                _gameButton(
                  context,
                  label: "Multiple Choice",
                  icon: Icons.quiz,
                  color: Colors.tealAccent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuizScreen(questions: quizQuestions),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // True or False
                _gameButton(
                  context,
                  label: "True or False",
                  icon: Icons.check_circle_outline,
                  color: Colors.lightBlueAccent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuizScreen(questions: trueFalseQuestions),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Matching Item
                _gameButton(
                  context,
                  label: "Matching Item",
                  icon: Icons.link,
                  color: Colors.orangeAccent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MatchingGameScreen(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Future Mode: Name Me (optional)
                /*
                _gameButton(
                  context,
                  label: "Name Me",
                  icon: Icons.lightbulb_outline,
                  color: Colors.pinkAccent,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('🔜 Name Me mode coming soon!')),
                    );
                  },
                ),
                */
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Game button builder
  Widget _gameButton(
      BuildContext context, {
        required String label,
        required IconData icon,
        required Color color,
        required VoidCallback onPressed,
      }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.6),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(width: 20),
            Text(
              label.toUpperCase(),
              style: GoogleFonts.pressStart2p(
                fontSize: 12,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
