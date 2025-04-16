import 'package:flutter/material.dart';
import '../widgets/animated_background.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, dynamic>> _leaderboardData = [
    {
      'name': 'John Doe',
      'position': 'President',
      'votes': 156,
      'image': 'https://via.placeholder.com/150?text=John+Doe',
      'trend': 'up',
    },
    {
      'name': 'Jane Smith',
      'position': 'President',
      'votes': 142,
      'image': 'https://via.placeholder.com/150?text=Jane+Smith',
      'trend': 'up',
    },
    {
      'name': 'Alex Johnson',
      'position': 'President',
      'votes': 128,
      'image': 'https://via.placeholder.com/150?text=Alex+Johnson',
      'trend': 'down',
    },
    {
      'name': 'Emma Watson',
      'position': 'Secretary',
      'votes': 98,
      'image': 'https://via.placeholder.com/150?text=Emma+Watson',
      'trend': 'up',
    },
    {
      'name': 'Chris Evans',
      'position': 'Secretary',
      'votes': 87,
      'image': 'https://via.placeholder.com/150?text=Chris+Evans',
      'trend': 'up',
    },
    {
      'name': 'Michael Lee',
      'position': 'Treasurer',
      'votes': 112,
      'image': 'https://via.placeholder.com/150?text=Michael+Lee',
      'trend': 'up',
    },
  ];

  String _selectedCategory = 'President';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Leaderboard',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list_rounded, color: Colors.white),
              onPressed: () {
                // Show filter options
              },
            ),
          ],
        ),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Overview
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatCard(
                          'Total Votes',
                          '623',
                          Icons.how_to_vote_rounded,
                          Colors.amber,
                        ),
                        _buildStatCard(
                          'Active Candidates',
                          '9',
                          Icons.people_rounded,
                          Colors.green,
                        ),
                        _buildStatCard(
                          'Positions',
                          '3',
                          Icons.workspace_premium_rounded,
                          Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Category Tabs
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildCategoryTab('President'),
                        _buildCategoryTab('Secretary'),
                        _buildCategoryTab('Treasurer'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Leaderboard List
                  ..._leaderboardData
                      .where((candidate) => candidate['position'] == _selectedCategory)
                      .toList()
                      .asMap()
                      .entries
                      .map((entry) {
                    final index = entry.key;
                    final candidate = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: _buildLeaderboardCard(
                        index + 1,
                        candidate['name'] as String,
                        candidate['position'] as String,
                        candidate['votes'] as int,
                        candidate['image'] as String,
                        candidate['trend'] as String,
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTab(String title) {
    final isSelected = title == _selectedCategory;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderboardCard(
    int rank,
    String name,
    String position,
    int votes,
    String imageUrl,
    String trend,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(imageUrl),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '#$rank',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          position,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$votes votes',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  trend == 'up' ? Icons.trending_up : Icons.trending_down,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  trend == 'up' ? '+12' : '-5',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 