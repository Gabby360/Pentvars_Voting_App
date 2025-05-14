import 'package:flutter/material.dart';
import '../widgets/animated_gradient_background.dart';
import '../widgets/gradient_card.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Election Results',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
            ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              GradientCard(
                opacity: 0.2,
                child: Row(
                  children: [
                  Container(
                      padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                    ),
                      child: const Icon(
                        Icons.leaderboard,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          const Text(
                            'Student Council Election 2024',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                        ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Results will be finalized in 2 days',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 16,
                            ),
                        ),
                      ],
                    ),
                  ),
                      ],
                    ),
                  ),
              const SizedBox(height: 30),
              Text(
                'Presidential Candidates',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              _buildResultsCard([
                {'name': 'John Smith', 'votes': 245, 'percentage': 45},
                {'name': 'Sarah Johnson', 'votes': 180, 'percentage': 33},
                {'name': 'Michael Brown', 'votes': 120, 'percentage': 22},
              ]),
              const SizedBox(height: 30),
        Text(
                'Secretary Candidates',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
              const SizedBox(height: 15),
              _buildResultsCard([
                {'name': 'Emily Davis', 'votes': 280, 'percentage': 52},
                {'name': 'David Wilson', 'votes': 150, 'percentage': 28},
                {'name': 'Lisa Anderson', 'votes': 110, 'percentage': 20},
              ]),
              const SizedBox(height: 30),
        Text(
                'Treasurer Candidates',
          style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              _buildResultsCard([
                {'name': 'James Miller', 'votes': 200, 'percentage': 37},
                {'name': 'Emma White', 'votes': 190, 'percentage': 35},
                {'name': 'Robert Taylor', 'votes': 155, 'percentage': 28},
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsCard(List<Map<String, dynamic>> results) {
    return GradientCard(
      child: Column(
        children: results.asMap().entries.map((entry) {
          final index = entry.key;
          final result = entry.value;
          final isLeading = index == 0;
          
          return Column(
            children: [
              if (index > 0) const Divider(color: Colors.white10, height: 30),
              Row(
          children: [
                  Container(
                    width: 40,
                    height: 40,
                decoration: BoxDecoration(
                      color: isLeading
                          ? Colors.amber.withOpacity(0.2)
                          : Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                    child: Center(
                child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: isLeading ? Colors.amber : Colors.white,
                          fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          result['name'],
                          style: TextStyle(
            color: Colors.white,
                            fontSize: isLeading ? 18 : 16,
                            fontWeight:
                                isLeading ? FontWeight.bold : FontWeight.normal,
          ),
        ),
                        const SizedBox(height: 8),
                        Stack(
                          children: [
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(3),
          ),
        ),
                            FractionallySizedBox(
                              widthFactor: result['percentage'] / 100,
                              child: Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  color: isLeading
                                      ? Colors.amber
                                      : Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
          children: [
            Text(
                              '${result['votes']} votes',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14,
              ),
                ),
                            const SizedBox(width: 10),
                Text(
                              '${result['percentage']}%',
                  style: const TextStyle(
                    color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
                  ),
                ],
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
} 