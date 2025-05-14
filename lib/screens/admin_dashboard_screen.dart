import 'package:flutter/material.dart';
import '../models/candidate_model.dart';
import '../services/admin_service.dart';
import 'admin/overview_screen.dart';
import 'admin/elections_screen.dart';
import 'admin/candidates_screen.dart';
import 'admin/results_screen.dart';
import 'admin/settings_screen.dart';
import 'admin/audit_logs_screen.dart';
import 'dart:ui';

class AdminDashboardScreen extends StatefulWidget {
  final int initialIndex;
  
  const AdminDashboardScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> with SingleTickerProviderStateMixin {
  final _adminService = AdminService();
  bool _isLoading = false;
  bool _isAdmin = true;
  bool _isElectionActive = false;
  List<CandidateModel> _candidates = [];
  bool _isSidebarCollapsed = false;
  late TabController _tabController;
  bool _isDarkMode = false;

  // Enhanced color scheme with beautiful gradients
  final Color _primaryColor = const Color(0xFF6C5CE7);
  final Color _secondaryColor = const Color(0xFF00B894);
  final Color _accentColor = const Color(0xFF00D2D3);
  final Color _errorColor = const Color(0xFFFF7675);
  final Color _successColor = const Color(0xFF00B894);
  final Color _warningColor = const Color(0xFFFDCB6E);

  // Beautiful background gradients
  final List<Color> _darkModeGradient = [
    const Color(0xFF0F0F1A),
    const Color(0xFF1A1A2E),
    const Color(0xFF2D1B69),
    const Color(0xFF1A1A2E),
  ];

  final List<Color> _lightModeGradient = [
    const Color(0xFFF8F9FE),
    const Color(0xFFF0F2FF),
    const Color(0xFFE8ECFF),
    const Color(0xFFF0F2FF),
  ];

  // Enhanced light mode colors
  final Color _lightBackground = const Color(0xFFF8F9FE);
  final Color _lightSurface = const Color(0xFFFFFFFF);
  final Color _lightCardBackground = const Color(0xFFFFFFFF);
  final Color _lightAccent = const Color(0xFFE8ECFF);
  final Color _lightBorder = const Color(0xFFE0E4FF);

  // Enhanced dark mode colors
  final Color _darkBackground = const Color(0xFF0F0F1A);
  final Color _darkSurface = const Color(0xFF1A1A2E);
  final Color _darkCardBackground = const Color(0xFF1A1A2E);
  final Color _darkAccent = const Color(0xFF2D1B69);
  final Color _darkBorder = const Color(0xFF2A2A3E);

  // Glassmorphism effect
  Widget _buildGlassEffect({required Widget child, double opacity = 0.1}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  // Custom tab indicator
  Widget _buildCustomTabIndicator(BuildContext context, TabController controller) {
    return Container(
      height: 3,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_primaryColor, _secondaryColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 6,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
    _loadInitialData();
  }

  void _loadInitialData() {
    _adminService.electionStatusStream.listen((isActive) {
      if (mounted) {
        setState(() {
          _isElectionActive = isActive;
        });
      }
    });

    _adminService.candidatesStream.listen((candidates) {
      if (mounted) {
        setState(() {
          _candidates = candidates;
        });
      }
    });
  }

  @override
  void dispose() {
    _adminService.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: _darkBackground,
              colorScheme: ColorScheme.dark(
                primary: _primaryColor,
                secondary: _secondaryColor,
                surface: _darkSurface,
                error: _errorColor,
                background: _darkBackground,
              ),
              cardTheme: CardTheme(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                color: _darkCardBackground,
              ),
              appBarTheme: AppBarTheme(
                elevation: 0,
                backgroundColor: _darkSurface,
                titleTextStyle: TextStyle(
                  color: _primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            )
          : ThemeData.light().copyWith(
              scaffoldBackgroundColor: _lightBackground,
              colorScheme: ColorScheme.light(
                primary: _primaryColor,
                secondary: _secondaryColor,
                surface: _lightSurface,
                error: _errorColor,
                background: _lightBackground,
              ),
              cardTheme: CardTheme(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                color: _lightCardBackground,
              ),
              appBarTheme: AppBarTheme(
                elevation: 0,
                backgroundColor: _lightSurface,
                titleTextStyle: TextStyle(
                  color: _primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(64),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6C63FF), Color(0xFF42A5F5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Drawer menu icon
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Builder(
                      builder: (context) => Material(
                        color: _isDarkMode ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(14),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () => Scaffold.of(context).openDrawer(),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(Icons.menu_rounded, size: 28, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Title
                  Expanded(
                    child: Center(
                      child: Text(
                        'Admin Dashboard',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          letterSpacing: 0.5,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Theme toggle
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Material(
                      color: _isDarkMode ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(14),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () {
                          setState(() {
                            _isDarkMode = !_isDarkMode;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            transitionBuilder: (child, anim) => RotationTransition(turns: anim, child: child),
                            child: Icon(
                              _isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                              key: ValueKey(_isDarkMode),
                              color: Colors.white,
                              size: 28,
                            ),
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
        drawer: MediaQuery.of(context).size.width <= 800 ? _buildSidebar(context) : null,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _isDarkMode ? _darkModeGradient : _lightModeGradient,
              stops: const [0.0, 0.3, 0.6, 1.0],
            ),
          ),
          child: Row(
            children: [
              if (!_isSidebarCollapsed && MediaQuery.of(context).size.width > 800)
                _buildSidebar(context),
              Expanded(
                child: Column(
                  children: [
                    _buildGlassEffect(
                      opacity: _isDarkMode ? 0.1 : 0.05,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        constraints: BoxConstraints(
                          maxHeight: 60,
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: TabBar(
                            controller: _tabController,
                            isScrollable: true,
                            labelColor: Color(0xFF6C63FF),
                            unselectedLabelColor: _isDarkMode ? Colors.white70 : Colors.black54,
                            indicatorColor: Color(0xFF6C63FF),
                            indicatorWeight: 3,
                            indicatorSize: TabBarIndicatorSize.label,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              letterSpacing: 0.5,
                            ),
                            tabs: [
                              _buildTab(Icons.dashboard_rounded, 'Overview'),
                              _buildTab(Icons.how_to_vote_rounded, 'Elections'),
                              _buildTab(Icons.person_rounded, 'Candidates'),
                              _buildTab(Icons.bar_chart_rounded, 'Results'),
                              _buildTab(Icons.settings_rounded, 'Settings'),
                              _buildTab(Icons.history_rounded, 'Audit Logs'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildTabContent(OverviewScreen(
                            onTabChange: (index) {
                              _tabController.animateTo(index);
                            },
                          )),
                          _buildTabContent(const ElectionsScreen()),
                          _buildTabContent(const CandidatesScreen()),
                          _buildTabContent(const ResultsScreen()),
                          _buildTabContent(const SettingsScreen()),
                          _buildTabContent(const AuditLogsScreen()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      constraints: const BoxConstraints(minWidth: 100),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: Color(0xFF6C63FF)),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Color(0xFF6C63FF)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: _isSidebarCollapsed ? 80 : 280,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _isDarkMode
              ? [
                  const Color(0xFF1A1A2E).withOpacity(0.95),
                  const Color(0xFF1A1A2E).withOpacity(0.98),
                ]
              : [
                  Colors.white.withOpacity(0.95),
                  Colors.white.withOpacity(0.98),
                ],
        ),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 0),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(_isSidebarCollapsed ? 16 : 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6C63FF), Color(0xFF42A5F5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: _primaryColor.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.admin_panel_settings_rounded,
                        size: 36,
                        color: Colors.white,
                      ),
                    ),
                ),
                if (!_isSidebarCollapsed) ...[
                  const SizedBox(height: 28),
                  _buildGlassEffect(
                    opacity: 0.15,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: const Icon(
                              Icons.email_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'admin@pentvars.edu.gh',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                _buildSidebarItem(Icons.dashboard_rounded, 'Dashboard Home', 0),
                _buildSidebarItem(Icons.how_to_vote_rounded, 'Elections', 1),
                _buildSidebarItem(Icons.person_rounded, 'Candidates', 2),
                _buildSidebarItem(Icons.bar_chart_rounded, 'Results', 3),
                _buildSidebarItem(Icons.settings_rounded, 'Settings', 4),
                _buildSidebarItem(Icons.history_rounded, 'Audit Logs', 5),
                const Divider(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/admin/login');
                    },
                    icon: const Icon(Icons.logout_rounded),
                    label: _isSidebarCollapsed ? const SizedBox() : const Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _errorColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, int tabIndex) {
    final isSelected = _tabController.index == tabIndex;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? (_isDarkMode ? _primaryColor.withOpacity(0.2) : _primaryColor.withOpacity(0.1))
            : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected
              ? _primaryColor.withOpacity(0.3)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSelected
                ? _primaryColor.withOpacity(0.2)
                : (_isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? _primaryColor.withOpacity(0.3)
                  : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Icon(
            icon,
            color: isSelected
                ? _primaryColor
                : (_isDarkMode ? Colors.white70 : Colors.black54),
          ),
        ),
        title: _isSidebarCollapsed
            ? null
            : Text(
                title,
                style: TextStyle(
                  color: isSelected
                      ? _primaryColor
                      : (_isDarkMode ? Colors.white70 : Colors.black87),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 15,
                ),
              ),
        onTap: () {
          setState(() {
            _tabController.animateTo(tabIndex);
          });
        },
      ),
    );
  }

  Widget _buildTabContent(Widget child) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _isDarkMode
              ? [
                  _darkSurface.withOpacity(0.95),
                  _darkAccent.withOpacity(0.98),
                ]
              : [
                  _lightSurface.withOpacity(0.95),
                  _lightAccent.withOpacity(0.98),
                ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: child,
        ),
      ),
    );
  }
} 