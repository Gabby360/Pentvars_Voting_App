import 'package:flutter/material.dart';
import '../widgets/animated_background.dart';

class DashboardScreen extends StatelessWidget {
  final ThemeMode currentTheme;
  final Function(bool) toggleTheme;

  const DashboardScreen({
    super.key,
    required this.currentTheme,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Dashboard',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                currentTheme == ThemeMode.dark
                    ? Icons.dark_mode
                    : Icons.light_mode,
                color: Colors.white,
              ),
              onPressed: () => toggleTheme(currentTheme != ThemeMode.dark),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.white.withOpacity(0.1),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.timer, color: Colors.white),
                  ),
                  title: const Text(
                    "Voting Ends In:",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    "02h 15m 30s",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.white.withOpacity(0.1),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.trending_up, color: Colors.white),
                  ),
                  title: const Text(
                    "Current Leader",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    "John Doe - President",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  dashboardTile(Icons.how_to_vote, "Vote", context),
                  dashboardTile(Icons.leaderboard, "Leaderboard", context),
                  dashboardTile(Icons.check_circle, "My Votes", context),
                  dashboardTile(Icons.info, "About", context),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                "Recent Activity",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ...List.generate(
                3,
                (index) => ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.verified,
                      color: Colors.lightGreenAccent,
                    ),
                  ),
                  title: Text(
                    "You voted for Candidate ${index + 1}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dashboardTile(IconData icon, String label, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (label == "Vote") {
          Navigator.pushNamed(context, '/voting');
        }
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 60) / 2,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 30, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 