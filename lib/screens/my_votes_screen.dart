import 'package:flutter/material.dart';
import '../widgets/animated_gradient_background.dart';
import '../widgets/gradient_card.dart';

class MyVotesScreen extends StatelessWidget {
  const MyVotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
              'My Votes',
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
                        Icons.how_to_vote,
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
                                'Voting History',
                            style: TextStyle(
                                      color: Colors.white,
                              fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                            'View your past election participation',
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
              _buildVoteHistoryCard(
                'Student Council Election 2024',
                DateTime(2024, 3, 15),
                {
                  'President': 'John Smith',
                  'Secretary': 'Emily Davis',
                  'Treasurer': 'James Miller',
                },
                true,
              ),
              const SizedBox(height: 20),
              _buildVoteHistoryCard(
                'Department Representative Election',
                DateTime(2024, 2, 1),
                {
                  'Representative': 'Sarah Wilson',
                  'Deputy': 'Michael Brown',
                },
                false,
                          ),
                        ],
                      ),
        ),
      ),
    );
  }

  Widget _buildVoteHistoryCard(
    String title,
    DateTime date,
    Map<String, String> votes,
    bool isActive,
  ) {
    return GradientCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                          style: const TextStyle(
                            color: Colors.white,
                        fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    const SizedBox(height: 5),
                            Text(
                      'Voted on ${date.day}/${date.month}/${date.year}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14,
                              ),
                            ),
                  ],
                              ),
                            ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                  color: isActive
                      ? Colors.green.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                          ),
                child: Text(
                  isActive ? 'Active' : 'Completed',
                  style: TextStyle(
                    color: isActive ? Colors.green[300] : Colors.grey[300],
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                        ),
                      ],
                    ),
          const SizedBox(height: 20),
          const Divider(color: Colors.white10),
          const SizedBox(height: 20),
          ...votes.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.key,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                              ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          entry.value,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 