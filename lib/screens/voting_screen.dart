import 'package:flutter/material.dart';
import '../widgets/animated_gradient_background.dart';
import '../widgets/gradient_card.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  final Map<String, String> selectedCandidates = {};
  final positions = ['President', 'Secretary', 'Treasurer'];
  
  final candidates = {
    'President': [
      {'name': 'John Smith', 'id': 'P1', 'bio': 'Dedicated to bringing positive change'},
      {'name': 'Sarah Johnson', 'id': 'P2', 'bio': 'Fighting for student rights'},
      {'name': 'Michael Brown', 'id': 'P3', 'bio': 'Building a better campus'},
    ],
    'Secretary': [
      {'name': 'Emily Davis', 'id': 'S1', 'bio': 'Organized and efficient'},
      {'name': 'David Wilson', 'id': 'S2', 'bio': 'Your voice matters'},
      {'name': 'Lisa Anderson', 'id': 'S3', 'bio': 'Experience that counts'},
    ],
    'Treasurer': [
      {'name': 'James Miller', 'id': 'T1', 'bio': 'Managing with integrity'},
      {'name': 'Emma White', 'id': 'T2', 'bio': 'Transparent leadership'},
      {'name': 'Robert Taylor', 'id': 'T3', 'bio': 'Financial expertise'},
    ],
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showCandidatesDialog(String position) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GradientCard(
            padding: const EdgeInsets.all(25),
          opacity: 0.15,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select $position',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 25),
                ...candidates[position]!.map((candidate) => Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedCandidates[position] = candidate['id']!;
                        });
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(15),
                    child: GradientCard(
                        padding: const EdgeInsets.all(20),
                      opacity: 0.1,
                      hasBorder: selectedCandidates[position] == candidate['id'],
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                candidate['name']![0],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    candidate['name']!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    candidate['bio']!,
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
                    ),
                  ),
                )),
              ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Cast Your Vote',
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
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
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
                                'Student Council Election 2024',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Select your candidates for each position',
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
                  ...positions.map((position) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                    child: GradientCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                    Text(
                                      position,
                                      style: const TextStyle(
                                        color: Colors.white,
                              fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                          const SizedBox(height: 15),
                          if (selectedCandidates[position] != null)
                            Row(
                                      children: [
                                        Expanded(
                                  child: Text(
                                    candidates[position]!
                                        .firstWhere((c) => c['id'] == selectedCandidates[position])['name']!,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.white),
                                  onPressed: () => _showCandidatesDialog(position),
                                ),
                              ],
                            )
                          else
                            FilledButton(
                              onPressed: () => _showCandidatesDialog(position),
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF1a237e),
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Select Candidate',
                                    style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ],
                      ),
                    ),
                  )),
                  const SizedBox(height: 30),
                  FilledButton(
                    onPressed: selectedCandidates.length == positions.length
                        ? () => Navigator.pushNamed(context, '/vote-confirmation')
                        : null,
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1a237e),
                      minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    child: const Text(
                      'Submit Vote',
                      style: TextStyle(
                        fontSize: 18,
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 