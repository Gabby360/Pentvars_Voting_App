import 'package:flutter/material.dart';
import '../widgets/animated_background.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Icon(
                    Icons.how_to_vote_rounded,
                    size: 90,
                    color: Colors.white
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  'Pentvars Campus Vote',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )
                ),
                Text(
                  'Make your voice count!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9)
                  )
                ),
                const Spacer(),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6C63FF),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 18
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: const Text('Get Started'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 