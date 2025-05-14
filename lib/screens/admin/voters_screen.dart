import 'package:flutter/material.dart';

class VotersScreen extends StatefulWidget {
  const VotersScreen({super.key});

  @override
  State<VotersScreen> createState() => _VotersScreenState();
}

class _VotersScreenState extends State<VotersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Voters Management',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : const Color(0xFF1E1E2D),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 16),
                if (!isSmallScreen)
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement add voter functionality
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Voter'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      shadowColor: const Color(0xFF6C63FF).withOpacity(0.3),
                    ),
                  )
                else
                  IconButton(
                    onPressed: () {
                      // TODO: Implement add voter functionality
                    },
                    icon: const Icon(Icons.add),
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            // Search and Filter Bar
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDarkMode 
                    ? [const Color(0xFF1A1A2E), const Color(0xFF2D1B69)]
                    : [Colors.white, Colors.white],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
                border: Border.all(
                  color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: isSmallScreen
                ? Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search voters...',
                          prefixIcon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.search),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey[100],
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: DropdownButton<String>(
                          value: 'All Elections',
                          isExpanded: true,
                          items: ['All Elections', 'Student Council 2024', 'Class Representative 2024']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            // TODO: Implement filter functionality
                          },
                          underline: const SizedBox(),
                          icon: const Icon(Icons.arrow_drop_down),
                          dropdownColor: isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search voters...',
                            prefixIcon: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.search),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: DropdownButton<String>(
                          value: 'All Elections',
                          items: ['All Elections', 'Student Council 2024', 'Class Representative 2024']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            // TODO: Implement filter functionality
                          },
                          underline: const SizedBox(),
                          icon: const Icon(Icons.arrow_drop_down),
                          dropdownColor: isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
            ),
            const SizedBox(height: 24),
            // Voters List
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDarkMode 
                    ? [const Color(0xFF1A1A2E), const Color(0xFF2D1B69)]
                    : [Colors.white, Colors.white],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
                border: Border.all(
                  color: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: isSmallScreen ? screenWidth - 48 : 800,
                  ),
                  child: DataTable(
                    columnSpacing: 16,
                    horizontalMargin: 16,
                    headingRowColor: MaterialStateProperty.all(
                      isDarkMode ? Colors.white.withOpacity(0.05) : Colors.grey[50],
                    ),
                    dataRowColor: MaterialStateProperty.all(
                      isDarkMode ? Colors.transparent : Colors.white,
                    ),
                    columns: [
                      DataColumn(
                        label: SizedBox(
                          width: isSmallScreen ? 60 : 80,
                          child: Text(
                            'ID',
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: isSmallScreen ? 120 : 150,
                          child: Text(
                            'Name',
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: isSmallScreen ? 160 : 200,
                          child: Text(
                            'Email',
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: isSmallScreen ? 80 : 100,
                          child: Text(
                            'Status',
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: isSmallScreen ? 80 : 100,
                          child: Text(
                            'Actions',
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                    rows: [
                      _buildVoterRow('V001', 'John Doe', 'john@example.com', 'Active', isDarkMode, isSmallScreen),
                      _buildVoterRow('V002', 'Jane Smith', 'jane@example.com', 'Active', isDarkMode, isSmallScreen),
                      _buildVoterRow('V003', 'Mike Johnson', 'mike@example.com', 'Inactive', isDarkMode, isSmallScreen),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildVoterRow(String id, String name, String email, String status, bool isDarkMode, bool isSmallScreen) {
    return DataRow(
      cells: [
        DataCell(
          SizedBox(
            width: isSmallScreen ? 60 : 80,
            child: Text(
              id,
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.black54,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: isSmallScreen ? 120 : 150,
            child: Text(
              name,
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.black54,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: isSmallScreen ? 160 : 200,
            child: Text(
              email,
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.black54,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: isSmallScreen ? 80 : 100,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: status == 'Active' 
                  ? Colors.green.withOpacity(0.1) 
                  : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: status == 'Active' 
                    ? Colors.green.withOpacity(0.2) 
                    : Colors.red.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: status == 'Active' ? Colors.green : Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: isSmallScreen ? 80 : 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () {
                    // TODO: Implement edit functionality
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20),
                  onPressed: () {
                    // TODO: Implement delete functionality
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
} 