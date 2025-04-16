import 'package:flutter/material.dart';
import '../widgets/animated_background.dart';

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
      {'name': 'John Smith', 'id': 'P1', 'votes': '245', 'bio': 'Dedicated to bringing positive change'},
      {'name': 'Sarah Johnson', 'id': 'P2', 'votes': '189', 'bio': 'Fighting for student rights'},
      {'name': 'Michael Brown', 'id': 'P3', 'votes': '156', 'bio': 'Building a better campus'},
    ],
    'Secretary': [
      {'name': 'Emily Davis', 'id': 'S1', 'votes': '178', 'bio': 'Organized and efficient'},
      {'name': 'David Wilson', 'id': 'S2', 'votes': '165', 'bio': 'Your voice matters'},
      {'name': 'Lisa Anderson', 'id': 'S3', 'votes': '143', 'bio': 'Experience that counts'},
    ],
    'Treasurer': [
      {'name': 'James Miller', 'id': 'T1', 'votes': '198', 'bio': 'Managing with integrity'},
      {'name': 'Emma White', 'id': 'T2', 'votes': '167', 'bio': 'Transparent leadership'},
      {'name': 'Robert Taylor', 'id': 'T3', 'votes': '145', 'bio': 'Financial expertise'},
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
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF6C63FF).withOpacity(0.95),
                const Color(0xFF9575CD).withOpacity(0.95),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF42A5F5).withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
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
              const SizedBox(height: 20),
              ...candidates[position]!.map((candidate) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
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
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: selectedCandidates[position] == candidate['id']
                            ? const Color(0xFF6C63FF).withOpacity(0.6)
                            : const Color(0xFF9575CD).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: selectedCandidates[position] == candidate['id']
                              ? Colors.white.withOpacity(0.6)
                              : Colors.white.withOpacity(0.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF42A5F5).withOpacity(0.2),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              candidate['name']![0],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  candidate['name']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  candidate['bio']!,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${candidate['votes']} votes',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )).toList(),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    if (selectedCandidates.length != positions.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select all positions'),
          backgroundColor: Colors.white.withOpacity(0.1),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF6C63FF).withOpacity(0.95),
                const Color(0xFF9575CD).withOpacity(0.95),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF42A5F5).withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Confirm Your Vote',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ...positions.map((position) {
                final candidateId = selectedCandidates[position];
                final candidate = candidates[position]!.firstWhere(
                  (c) => c['id'] == candidateId,
                );
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF9575CD).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            position[0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                position,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                candidate['name']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/confirmation');
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6C63FF),
                    ),
                    child: const Text('Confirm Vote'),
                  ),
                ],
              ),
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
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF6C63FF).withOpacity(0.95),
                          const Color(0xFF9575CD).withOpacity(0.95),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.how_to_vote_rounded,
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
                                'Make Your Choice',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Select one candidate for each position',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: positions.length,
                      itemBuilder: (context, index) {
                        final position = positions[index];
                        final isSelected = selectedCandidates.containsKey(position);
                        final selectedId = selectedCandidates[position];
                        final selectedCandidate = isSelected
                            ? candidates[position]!.firstWhere(
                                (c) => c['id'] == selectedId,
                              )
                            : null;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => _showCandidatesDialog(position),
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFF6C63FF).withOpacity(0.3),
                                      const Color(0xFF9575CD).withOpacity(0.3),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.white.withOpacity(0.3)
                                        : Colors.white.withOpacity(0.1),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.2),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            position[0],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        Text(
                                          position,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (isSelected) ...[
                                      const SizedBox(height: 15),
                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.2),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.check_rounded,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    selectedCandidate!['name']!,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    selectedCandidate['bio']!,
                                                    style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.7),
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ] else ...[
                                      const SizedBox(height: 10),
                                      Text(
                                        'Tap to select a candidate',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _showConfirmationDialog,
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF6C63FF),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        selectedCandidates.length == positions.length
                            ? 'Review and Submit'
                            : 'Select All Positions (${selectedCandidates.length}/${positions.length})',
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