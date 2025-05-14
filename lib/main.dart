import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'screens/about_screen.dart';
import 'screens/confirmation_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/landing_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/login_screen.dart';
import 'screens/my_votes_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/voting_screen.dart';
import 'screens/admin_portal_screen.dart';
import 'screens/admin_dashboard_screen.dart';
import 'screens/admin_login_screen.dart';
import 'screens/vote_now_screen.dart';
import 'screens/thank_you_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const VotingApp());
}

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
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/dashboard': (context) => DashboardScreen(
              toggleTheme: _toggleTheme,
              currentTheme: _themeMode,
            ),
        '/voting': (context) => const VotingScreen(),
        '/vote-now': (context) => const VoteNowScreen(),
        '/vote-confirmation': (context) => const VoteConfirmationScreen(),
        '/thank-you': (context) => const ThankYouScreen(),
        '/myvotes': (context) => const MyVotesScreen(),
        '/leaderboard': (context) => const LeaderboardScreen(),
        '/about': (context) => const AboutScreen(),
        '/admin/login': (context) => const AdminLoginScreen(),
        '/admin': (context) => const AdminDashboardScreen(),
        '/admin/elections': (context) => const AdminDashboardScreen(initialIndex: 1),
        '/admin/candidates': (context) => const AdminDashboardScreen(initialIndex: 3),
        '/admin/voters': (context) => const AdminDashboardScreen(initialIndex: 2),
        '/admin/results': (context) => const AdminDashboardScreen(initialIndex: 4),
      },
      builder: (context, child) {
        return Scaffold(
          body: child,
        );
      },
    );
  }
}
