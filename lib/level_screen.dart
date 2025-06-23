import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'game_choice_screen.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D47A1), Color(0xFF311B92)],
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
                Text(
                  '🚀 CHOOSE LEVEL',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.pressStart2p(
                    color: Colors.yellowAccent,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 50),

                _levelButton(
                  label: "Easy",
                  icon: Icons.emoji_emotions,
                  color: Colors.greenAccent,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const GameChoiceScreen()));
                  },
                ),
                const SizedBox(height: 20),

                _levelButton(
                  label: "Medium",
                  icon: Icons.bolt,
                  color: Colors.orangeAccent,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const GameChoiceScreen()));
                  },
                ),
                const SizedBox(height: 20),

                _levelButton(
                  label: "Hard",
                  icon: Icons.whatshot,
                  color: Colors.redAccent,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const GameChoiceScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _levelButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
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
