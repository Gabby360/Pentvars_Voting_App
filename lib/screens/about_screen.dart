import 'package:flutter/material.dart';
import '../widgets/animated_background.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'About',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.how_to_vote_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Campus Vote',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Your trusted platform for secure and transparent campus elections.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Features Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: constraints.maxWidth > 400 ? 1.2 : 0.95,
                    children: [
                      _buildFeatureCard(
                        icon: Icons.security_rounded,
                        title: 'Secure Voting',
                        description: 'End-to-end encryption ensures your vote remains confidential.',
                      ),
                      _buildFeatureCard(
                        icon: Icons.verified_user_rounded,
                        title: 'Verified Users',
                        description: 'Only registered students can participate in elections.',
                      ),
                      _buildFeatureCard(
                        icon: Icons.bar_chart_rounded,
                        title: 'Live Results',
                        description: 'Real-time updates on election progress.',
                      ),
                      _buildFeatureCard(
                        icon: Icons.history_rounded,
                        title: 'Vote History',
                        description: 'Track your voting history and participation.',
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              // Contact Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF6C63FF).withOpacity(0.3),
                      const Color(0xFF42A5F5).withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Contact Us',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildContactItem(Icons.email_rounded, 'gabbymiles@gmaill.com'),
                    _buildContactItem(Icons.phone_rounded, '0594891338'),
                    _buildContactItem(Icons.location_on_rounded, 'Pentecost University'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Version Info
              Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6C63FF).withOpacity(0.3),
                  const Color(0xFF9575CD).withOpacity(0.3),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Text(
              description,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 