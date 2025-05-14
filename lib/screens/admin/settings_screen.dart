import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  String _selectedLanguage = 'English';
  String _selectedTimeZone = 'UTC+0';
  bool _twoFactorAuth = false;
  bool _autoLogout = true;
  double _sessionTimeout = 30.0;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 1200;

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : const Color(0xFF1E1E2D),
              ),
            ),
            const SizedBox(height: 24),
            // Settings Sections
            _buildSettingsSection(
              'Appearance',
              [
                _buildSwitchTile(
                  'Dark Mode',
                  'Enable dark theme for the application',
                  _darkMode,
                  (value) {
                    setState(() {
                      _darkMode = value;
                    });
                  },
                  Icons.dark_mode,
                ),
                _buildDropdownTile(
                  'Language',
                  'Select your preferred language',
                  _selectedLanguage,
                  ['English', 'Spanish', 'French', 'German', 'Chinese'],
                  (value) {
                    if (value != null) {
                      setState(() {
                        _selectedLanguage = value;
                      });
                    }
                  },
                  Icons.language,
                ),
              ],
              isDarkMode,
            ),
            const SizedBox(height: 24),
            _buildSettingsSection(
              'Notifications',
              [
                _buildSwitchTile(
                  'Enable Notifications',
                  'Receive notifications about election updates',
                  _notificationsEnabled,
                  (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                  Icons.notifications,
                ),
                _buildSwitchTile(
                  'Email Notifications',
                  'Receive notifications via email',
                  _emailNotifications,
                  (value) {
                    setState(() {
                      _emailNotifications = value;
                    });
                  },
                  Icons.email,
                ),
                _buildSwitchTile(
                  'SMS Notifications',
                  'Receive notifications via SMS',
                  _smsNotifications,
                  (value) {
                    setState(() {
                      _smsNotifications = value;
                    });
                  },
                  Icons.sms,
                ),
              ],
              isDarkMode,
            ),
            const SizedBox(height: 24),
            _buildSettingsSection(
              'Security',
              [
                _buildSwitchTile(
                  'Two-Factor Authentication',
                  'Add an extra layer of security to your account',
                  _twoFactorAuth,
                  (value) {
                    setState(() {
                      _twoFactorAuth = value;
                    });
                  },
                  Icons.security,
                ),
                _buildSwitchTile(
                  'Auto Logout',
                  'Automatically log out after a period of inactivity',
                  _autoLogout,
                  (value) {
                    setState(() {
                      _autoLogout = value;
                    });
                  },
                  Icons.logout,
                ),
                _buildSliderTile(
                  'Session Timeout',
                  'Minutes before automatic logout',
                  _sessionTimeout,
                  5.0,
                  60.0,
                  (value) {
                    setState(() {
                      _sessionTimeout = value.toDouble();
                    });
                  },
                  Icons.timer,
                ),
              ],
              isDarkMode,
            ),
            const SizedBox(height: 24),
            _buildSettingsSection(
              'System',
              [
                _buildDropdownTile(
                  'Time Zone',
                  'Select your local time zone',
                  _selectedTimeZone,
                  ['UTC+0', 'UTC+1', 'UTC+2', 'UTC+3', 'UTC+4', 'UTC+5', 'UTC+6'],
                  (value) {
                    if (value != null) {
                      setState(() {
                        _selectedTimeZone = value;
                      });
                    }
                  },
                  Icons.access_time,
                ),
                _buildButtonTile(
                  'Clear Cache',
                  'Remove temporary files and data',
                  () {
                    // TODO: Implement clear cache functionality
                  },
                  Icons.cleaning_services,
                ),
                _buildButtonTile(
                  'Export Data',
                  'Download all election data',
                  () {
                    // TODO: Implement export data functionality
                  },
                  Icons.download,
                ),
              ],
              isDarkMode,
            ),
            const SizedBox(height: 24),
            // Save Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement save settings functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(
    String title,
    List<Widget> children,
    bool isDarkMode,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E2D) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
    IconData icon,
  ) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF6C63FF).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF6C63FF),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: isDarkMode ? Colors.white60 : Colors.black54,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF6C63FF),
      ),
    );
  }

  Widget _buildDropdownTile(
    String title,
    String subtitle,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
    IconData icon,
  ) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF6C63FF).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF6C63FF),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: isDarkMode ? Colors.white60 : Colors.black54,
        ),
      ),
      trailing: DropdownButton<String>(
        value: value,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
        underline: const SizedBox(),
      ),
    );
  }

  Widget _buildSliderTile(
    String title,
    String subtitle,
    double value,
    double min,
    double max,
    ValueChanged<double> onChanged,
    IconData icon,
  ) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF6C63FF).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF6C63FF),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle,
            style: TextStyle(
              color: isDarkMode ? Colors.white60 : Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: value,
                  min: min,
                  max: max,
                  divisions: 11,
                  label: value.round().toString(),
                  onChanged: onChanged,
                  activeColor: const Color(0xFF6C63FF),
                ),
              ),
              Text(
                '${value.round()} min',
                style: TextStyle(
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonTile(
    String title,
    String subtitle,
    VoidCallback onPressed,
    IconData icon,
  ) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF6C63FF).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF6C63FF),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: isDarkMode ? Colors.white60 : Colors.black54,
        ),
      ),
      trailing: TextButton(
        onPressed: onPressed,
        child: const Text('Execute'),
      ),
    );
  }
} 