import 'package:flutter/material.dart';
import 'screens/landing_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/confirmation_screen.dart';
import 'screens/my_votes_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/about_screen.dart';
import 'screens/voting_screen.dart';
import 'widgets/animated_background.dart';

void main() => runApp(const VotingApp());

class VotingApp extends StatefulWidget {
  const VotingApp({super.key});

  @override
  State<VotingApp> createState() => _VotingAppState();
}

class _VotingAppState extends State<VotingApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Vote',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: _themeMode,
      initialRoute: '/landing',
      routes: {
        '/landing': (context) => const LandingScreen(),
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => DashboardScreen(
              toggleTheme: _toggleTheme,
              currentTheme: _themeMode,
            ),
        '/voting': (context) => const VotingScreen(),
        '/confirmation': (context) => const VoteConfirmationScreen(),
        '/myvotes': (context) => const MyVotesScreen(),
        '/leaderboard': (context) => const LeaderboardScreen(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}

const appGradient = LinearGradient(
  colors: [Color(0xFF6C63FF), Color(0xFF9575CD), Color(0xFF42A5F5)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                    height: 180,
                    width: 180,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(40),
                  ),
                    child: const Icon(
                      Icons.how_to_vote_rounded,
                      size: 90,
                      color: Colors.white,
                    ),
                ),
                const SizedBox(height: 50),
                  Text(
                    'Campus Vote',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Make your voice count!',
                    style: TextStyle(
                        fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                const Spacer(),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6C63FF),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 18,
                      ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
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
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Login to Vote',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Use your student ID to login',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 30),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter Student ID',
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                      prefixIcon: const Icon(
                        Icons.person_outline_rounded,
                        color: Colors.white70,
                  ),
                ),
                  ),
                  const SizedBox(height: 30),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6C63FF),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/dashboard');
                  },
                  child: const Text('Login'),
                ),
                const Spacer(),
              ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  final ThemeMode currentTheme;
  final Function(bool) toggleTheme;

  const DashboardScreen({
    super.key,
    required this.currentTheme,
    required this.toggleTheme,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

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
            'Dashboard',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                widget.currentTheme == ThemeMode.dark
                    ? Icons.dark_mode
                    : Icons.light_mode,
                color: Colors.white,
              ),
              onPressed: () => widget.toggleTheme(widget.currentTheme != ThemeMode.dark),
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
                  // Welcome Card
                  Container(
                    decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.person_outline_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome Back!',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Make your voice count in the campus elections',
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
                  // Timer Card
                  Container(
                    decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                child: ListTile(
                      contentPadding: const EdgeInsets.all(20),
                      leading: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.timer_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      title: const Text(
                        "Voting Ends In",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: const Text(
                        "02h 15m 30s",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                ),
              ),
              const SizedBox(height: 20),
                  // Current Leader Card
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(20),
                      leading: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.emoji_events_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      title: const Text(
                        "Current Leader",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: const Text(
                        "John Doe - President",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
          ),
        ),
      ),
                  ),
                  const SizedBox(height: 30),
                  // Quick Actions Title
                  Text(
                    "Quick Actions",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 15),
                  // Quick Actions Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    children: [
                      _buildActionCard(
                        Icons.how_to_vote_rounded,
                        "Vote Now",
                        "Cast your vote",
                        context,
                        '/voting',
                      ),
                      _buildActionCard(
                        Icons.leaderboard_rounded,
                        "Leaderboard",
                        "View rankings",
                        context,
                        '/leaderboard',
                      ),
                      _buildActionCard(
                        Icons.check_circle_rounded,
                        "My Votes",
                        "View history",
                        context,
                        '/myvotes',
                      ),
                      _buildActionCard(
                        Icons.info_rounded,
                        "About",
                        "Learn more",
                        context,
                        '/about',
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Recent Activity Title
                  Text(
                    "Recent Activity",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 15),
                  // Recent Activity List
              ...List.generate(
                3,
                    (index) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(15),
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.verified_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          "You voted for Candidate ${index + 1}",
                              style: const TextStyle(
                                  color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          "2 hours ago",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 12,
                          ),
                        ),
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

  Widget _buildActionCard(
    IconData icon,
    String title,
    String subtitle,
    BuildContext context,
    String route,
  ) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                        color: Colors.white,
                size: 30,
              ),
                  ),
                  const SizedBox(height: 10),
            Text(
              title,
                      style: const TextStyle(
                          color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
