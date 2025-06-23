import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

import 'auth_screen.dart';
import 'register_screen.dart';
import 'login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.pressStart2pTextTheme(ThemeData.dark().textTheme),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  int _xp = 120;
  int _level = 3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _generatePlayerTag() {
    List<String> tags = ['🔥', '⚡', '🧠', '🎯', 'XP', 'LVL', 'PRO', 'BOT', 'ELITE', '💥'];
    return tags[_level % tags.length];
  }

  Future<void> _downloadAndOpenPdf() async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Storage permission denied')),
        );
        return;
      }
    }

    try {
      final byteData = await rootBundle.load('assets/files/yourfile.pdf');
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/yourfile.pdf');
      await file.writeAsBytes(byteData.buffer.asUint8List());
      await OpenFile.open(file.path);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PDF downloaded and opened!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error opening PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      drawer: _buildDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1D2671), Color(0xFFC33764)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildAvatarWithLevel(),
                  const SizedBox(height: 20),
                  _buildXPBar(),
                  const SizedBox(height: 40),
                  _animatedButton('LOGIN', Colors.greenAccent, () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                  }),
                  const SizedBox(height: 20),
                  _animatedButton('REGISTER', Colors.orangeAccent, () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen()));
                  }),
                  // const SizedBox(height: 20),
                  // _animatedButton('DOWNLOAD BYLAW PDF', Colors.blueAccent, () {
                  //   _downloadAndOpenPdf();
                  // }),
                  const SizedBox(height: 40),
                  _dailyRewardButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarWithLevel() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 50,
          child: Text(
            _generatePlayerTag(),
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ),
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.amber,
          child: Text(
            '$_level',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildXPBar() {
    return Column(
      children: [
        LinearProgressIndicator(
          value: _xp / 200,
          backgroundColor: Colors.black26,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.amberAccent),
          minHeight: 10,
        ),
        const SizedBox(height: 10),
        Text(
          'XP: $_xp / 200',
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
      ],
    );
  }

  Widget _animatedButton(String label, Color glowColor, VoidCallback onPressed) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: glowColor,
          elevation: 10,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          side: BorderSide(color: glowColor, width: 2),
        ),
        child: Text(label),
      ),
    );
  }

  Widget _dailyRewardButton() {
    return TextButton.icon(
      onPressed: _claimReward,
      icon: const Icon(Icons.card_giftcard, color: Colors.amberAccent),
      label: const Text(
        'Claim Daily Reward',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  void _claimReward() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('🎁 Daily Reward'),
        content: const Text('You earned +20 XP!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );

    setState(() {
      _xp += 20;
      if (_xp >= 200) {
        _xp -= 200;
        _level += 1;
      }
    });
  }

  Drawer _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF111222),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Text('🎮 MENU', style: TextStyle(color: Colors.white, fontSize: 22)),
          ),
          _drawerItem(Icons.person, 'Profile', () {}),
          _drawerItem(Icons.emoji_events, 'Leaderboard', () {}),
          _drawerItem(Icons.settings, 'Settings', () {}),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.amber),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
