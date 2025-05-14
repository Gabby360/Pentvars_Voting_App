import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class OverviewScreen extends StatelessWidget {
  final Function(int)? onTabChange;
  
  const OverviewScreen({
    super.key,
    this.onTabChange,
  });

  void _handleTabChange(BuildContext context, int tabIndex) {
    if (onTabChange != null) {
      onTabChange!(tabIndex);
    }
  }

  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showCreateElectionDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final startDateController = TextEditingController();
    final endDateController = TextEditingController();
    final candidateNameController = TextEditingController();
    final categoryController = TextEditingController();
    List<Map<String, String>> candidates = [];
    List<String> categories = [];
    String? selectedCategory;
    DateTime? startDate;
    DateTime? endDate;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            void addCategory() {
              if (categoryController.text.isNotEmpty &&
                  !categories.contains(categoryController.text)) {
                setState(() {
                  categories.add(categoryController.text);
                  categoryController.clear();
                });
              }
            }

            void addCandidate() {
              if (candidateNameController.text.isNotEmpty && selectedCategory != null) {
                setState(() {
                  candidates.add({
                    'name': candidateNameController.text,
                    'category': selectedCategory!,
                  });
                  candidateNameController.clear();
                  // Don't reset selectedCategory to allow adding multiple candidates in same category
                });
              }
            }

            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1A1A2E).withOpacity(0.95),
                      Color(0xFF2D1B69).withOpacity(0.95),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Text(
                          'Create New Election',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 24),

                        // Basic Info Section
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Basic Information',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              // Title
                              TextFormField(
                                controller: titleController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: 'Election Title',
                                  labelStyle: TextStyle(color: Colors.white70),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                validator: (value) => value?.isEmpty ?? true ? 'Please enter a title' : null,
                              ),
                              SizedBox(height: 16),
                              // Description
                              TextFormField(
                                controller: descriptionController,
                                style: TextStyle(color: Colors.white),
                                maxLines: 2,
                                decoration: InputDecoration(
                                  labelText: 'Description',
                                  labelStyle: TextStyle(color: Colors.white70),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                validator: (value) => value?.isEmpty ?? true ? 'Please enter a description' : null,
                              ),
                              SizedBox(height: 16),
                              // Dates
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: startDateController,
                                      style: TextStyle(color: Colors.white),
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        labelText: 'Start Date',
                                        labelStyle: TextStyle(color: Colors.white70),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      onTap: () async {
                                        final date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.now().add(Duration(days: 365)),
                                        );
                                        if (date != null) {
                                          setState(() {
                                            startDate = date;
                                            startDateController.text = date.toString().split(' ')[0];
                                          });
                                        }
                                      },
                                      validator: (value) => value?.isEmpty ?? true ? 'Please select start date' : null,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: TextFormField(
                                      controller: endDateController,
                                      style: TextStyle(color: Colors.white),
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        labelText: 'End Date',
                                        labelStyle: TextStyle(color: Colors.white70),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      onTap: () async {
                                        final date = await showDatePicker(
                                          context: context,
                                          initialDate: startDate ?? DateTime.now(),
                                          firstDate: startDate ?? DateTime.now(),
                                          lastDate: DateTime.now().add(Duration(days: 365)),
                                        );
                                        if (date != null) {
                                          setState(() {
                                            endDate = date;
                                            endDateController.text = date.toString().split(' ')[0];
                                          });
                                        }
                                      },
                                      validator: (value) => value?.isEmpty ?? true ? 'Please select end date' : null,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),

                        // Categories Section
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Categories',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: categoryController,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        labelText: 'Category Name',
                                        labelStyle: TextStyle(color: Colors.white70),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  ElevatedButton(
                                    onPressed: () => addCategory(),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF6C63FF),
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text('Add'),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              if (categories.isEmpty)
                                Center(
                                  child: Text(
                                    'No categories added yet',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                )
                              else
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: categories.map((category) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF6C63FF).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            category,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          SizedBox(width: 8),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                categories.remove(category);
                                              });
                                            },
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white70,
                                              size: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),

                        // Candidates Section
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Candidates',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              // Modify the candidate add section to include category selection
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      controller: candidateNameController,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        labelText: 'Candidate Name',
                                        labelStyle: TextStyle(color: Colors.white70),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    flex: 1,
                                    child: DropdownButtonFormField<String>(
                                      value: selectedCategory,
                                      dropdownColor: Color(0xFF1A1A2E),
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        labelText: 'Category',
                                        labelStyle: TextStyle(color: Colors.white70),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      items: categories.map((category) {
                                        return DropdownMenuItem(
                                          value: category,
                                          child: Text(
                                            category,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedCategory = value;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  ElevatedButton(
                                    onPressed: categories.isEmpty ? null : () => addCandidate(),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF6C63FF),
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text('Add'),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              // Update the candidates list to show categories
                              if (candidates.isEmpty)
                                Center(
                                  child: Text(
                                    'No candidates added yet',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                )
                              else
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: candidates.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  candidates[index]['name'] ?? '',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF6C63FF).withOpacity(0.1),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Text(
                                                    candidates[index]['category'] ?? '',
                                                    style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete, color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                candidates.removeAt(index);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),

                        // Action Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.white70),
                              ),
                            ),
                            SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (candidates.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Please add at least one candidate'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return;
                                  }
                                  // TODO: Save election data
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Election created successfully'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF6C63FF),
                                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Create Election',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showAddCandidateDialog(
    BuildContext context,
    List<String> categories,
    Function(String name, String category) onAdd,
  ) {
    final nameController = TextEditingController();
    String? selectedCategory;
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1A1A2E).withOpacity(0.95),
                  Color(0xFF2D1B69).withOpacity(0.95),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add Candidate',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    child: TextFormField(
                      controller: nameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Candidate Name',
                        labelStyle: TextStyle(color: Colors.white70),
                        prefixIcon: Icon(Icons.person, color: Color(0xFF6C63FF)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Color(0xFF6C63FF),
                            width: 1,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter candidate name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  if (categories.isEmpty)
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.red.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning,
                            color: Colors.red,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Please add at least one category before adding candidates',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: selectedCategory,
                        dropdownColor: Color(0xFF1A1A2E),
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Category',
                          labelStyle: TextStyle(color: Colors.white70),
                          prefixIcon: Icon(Icons.category, color: Color(0xFF6C63FF)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color(0xFF6C63FF),
                              width: 1,
                            ),
                          ),
                        ),
                        items: categories.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(
                              category,
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectedCategory = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a category';
                          }
                          return null;
                        },
                      ),
                    ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: categories.isEmpty
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  onAdd(nameController.text, selectedCategory!);
                                  Navigator.of(context).pop();
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF6C63FF),
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigateToTab(BuildContext context, int tabIndex) {
    _handleTabChange(context, tabIndex);
  }

  void _handleQuickAction(BuildContext context, VoidCallback action, [int tabIndex = 0]) {
    _navigateToTab(context, tabIndex);
    action();
  }

  Widget _buildHeader(BuildContext context, BoxConstraints constraints) {
    final isSmallScreen = constraints.maxWidth < 600;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 16 : 32,
        vertical: isSmallScreen ? 20 : 32
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A1A2E).withOpacity(0.7),
            Color(0xFF2D1B69).withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(isSmallScreen ? 32 : 64),
          bottomRight: Radius.circular(isSmallScreen ? 32 : 64),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF2D1B69).withOpacity(0.4),
            blurRadius: 50,
            spreadRadius: 5,
            offset: Offset(0, 20),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withOpacity(0.2),
                            Colors.white.withOpacity(0.05),
                          ],
                          stops: [0.3, 1],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 2,
                            offset: Offset(-5, -5),
                          ),
                          BoxShadow(
                            color: Color(0xFF2D1B69).withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 2,
                            offset: Offset(5, 5),
                          )
                        ],
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: isSmallScreen ? 24 : 32,
                      ),
                    ).animate().fade(duration: 800.ms).scale(duration: 800.ms),
                    SizedBox(width: isSmallScreen ? 16 : 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back,',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: isSmallScreen ? 14 : 16,
                              letterSpacing: 0.7,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Admin',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isSmallScreen ? 24 : 32,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ).animate().fade(duration: 800.ms).slideX(begin: -0.1, duration: 800.ms),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatPill(IconData icon, String label, Color color) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 200),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.18),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(BuildContext context, bool isSmallScreen, Color primaryColor, Color secondaryColor, Color errorColor, Color successColor, bool isDarkMode) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth < 600 ? 1 : 
                             constraints.maxWidth < 900 ? 2 : 
                             constraints.maxWidth < 1200 ? 2 : 3;
        
        final childAspectRatio = constraints.maxWidth < 600 ? 1.6 : 
                                constraints.maxWidth < 900 ? 1.4 : 1.3;
        
        return Container(
          padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1A1A2E).withOpacity(0.1),
                Color(0xFF2D1B69).withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: primaryColor.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF1A1A2E).withOpacity(0.2),
                          Color(0xFF2D1B69).withOpacity(0.2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: primaryColor.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Icon(Icons.trending_up, color: primaryColor, size: 20),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          successColor.withOpacity(0.2),
                          successColor.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: successColor.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_upward,
                          color: successColor,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '12%',
                          style: TextStyle(
                            color: successColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '1,234',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: isSmallScreen ? 24 : 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Total Voters',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmallScreen ? 12 : 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Active registered voters',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: isSmallScreen ? 10 : 12,
                  letterSpacing: 0.3,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMetricsGrid(
    BuildContext context,
    bool isSmallScreen,
    Color primaryColor,
    Color secondaryColor,
    Color errorColor,
    Color successColor,
    bool isDarkMode,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth < 600 ? 1 : 
                             constraints.maxWidth < 900 ? 2 : 
                             constraints.maxWidth < 1200 ? 2 : 3;
        
        final childAspectRatio = constraints.maxWidth < 600 ? 1.6 : 
                                constraints.maxWidth < 900 ? 1.4 : 1.3;
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            mainAxisSpacing: isSmallScreen ? 12 : 16,
            crossAxisSpacing: isSmallScreen ? 12 : 16,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            final metrics = [
              {
                'title': 'Total Voters',
                'value': '1,234',
                'icon': Icons.people,
                'color': primaryColor,
                'trend': '↑ 12% from last month',
                'subtitle': 'Active registered voters',
              },
              {
                'title': 'Active Elections',
                'value': '2',
                'icon': Icons.how_to_vote,
                'color': secondaryColor,
                'trend': '2 elections in progress',
                'subtitle': 'Ongoing voting processes',
              },
              {
                'title': 'Total Candidates',
                'value': '15',
                'icon': Icons.person,
                'color': errorColor,
                'trend': '↑ 3 new candidates',
                'subtitle': 'Registered candidates',
              },
              {
                'title': 'Votes Cast',
                'value': '856',
                'icon': Icons.check_circle,
                'color': successColor,
                'trend': '69% voter turnout',
                'subtitle': 'Total votes recorded',
              }
            ];
            
            final metric = metrics[index];
            return _buildMetricCard(
              context,
              isSmallScreen,
              metric['color'] as Color,
              metric['color'] as Color,
              metric['color'] as Color,
              metric['color'] as Color,
              isDarkMode,
            );
          },
        );
      },
    );
  }

  Widget _buildActivityList(BuildContext context) {
    final activities = [
      {'title': 'New voter registered', 'time': '2 minutes ago', 'icon': Icons.person_add},
      {'title': 'Election results published', 'time': '1 hour ago', 'icon': Icons.bar_chart},
      {'title': 'New candidate added', 'time': '3 hours ago', 'icon': Icons.person},
      {'title': 'System maintenance completed', 'time': '1 day ago', 'icon': Icons.build},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Row(
          children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  activity['icon'] as IconData,
                  color: Colors.white70,
                  size: 20,
                ),
            ),
              const SizedBox(width: 16),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity['title'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      activity['time'] as String,
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
            ),
          ],
          ),
        );
      },
    );
  }

  Widget _buildRecentActivity(BuildContext context, bool isDarkMode, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 20 : 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6C63FF).withOpacity(0.15),
            Color(0xFF42A5F5).withOpacity(0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF42A5F5).withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.notifications_active,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(width: isSmallScreen ? 12 : 16),
              const Text(
                'Recent Activity',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: isSmallScreen ? 16 : 24),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return _buildActivityItem(
                'Activity ${index + 1}',
                'Description for activity ${index + 1}',
                DateTime.now().subtract(Duration(hours: index)),
                isDarkMode,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContentSections(BuildContext context, bool isSmallScreen, bool isDarkMode) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useColumn = constraints.maxWidth < 900;
        final spacing = isSmallScreen ? 16.0 : 24.0;
        
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildQuickActions(context, isDarkMode, isSmallScreen),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildQuickActions(BuildContext context, bool isDarkMode, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6C63FF).withOpacity(0.15),
            Color(0xFF42A5F5).withOpacity(0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF42A5F5).withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(
              color: Colors.white,
              fontSize: isSmallScreen ? 18 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth < 600 ? 1 : 
                                   constraints.maxWidth < 900 ? 2 : 2;
              final childAspectRatio = constraints.maxWidth < 600 ? 4.0 : 
                                     constraints.maxWidth < 900 ? 3.5 : 4.0;
              
              return GridView.count(
                shrinkWrap: true,
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: isSmallScreen ? 8 : 12,
                crossAxisSpacing: isSmallScreen ? 8 : 12,
                childAspectRatio: childAspectRatio,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildActionCard(
                    context,
                    'Start New Election',
                    Icons.how_to_vote,
                    'Create and configure a new election',
                    () => _showCreateElectionDialog(context),
                    Colors.white,
                  ),
                  _buildActionCard(
                    context,
                    'View Candidates',
                    Icons.people,
                    'Access the complete list of candidates',
                    () => _handleTabChange(context, 2),
                    Colors.white,
                  ),
                  _buildActionCard(
                    context,
                    'View Results',
                    Icons.bar_chart,
                    'Check election results and statistics',
                    () => _handleTabChange(context, 3),
                    Colors.white,
                  ),
                  _buildActionCard(
                    context,
                    'Settings',
                    Icons.settings,
                    'Configure system settings',
                    () => _handleTabChange(context, 4),
                    Colors.white,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,
    String description,
    VoidCallback onPressed,
    Color accentColor,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;
        
        return Container(
          constraints: BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        icon,
                        color: accentColor,
                        size: isSmallScreen ? 18 : 20,
                      ),
                    ),
                    SizedBox(width: isSmallScreen ? 8 : 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isSmallScreen ? 12 : 14,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            description,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: isSmallScreen ? 10 : 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  Widget _buildActivityItem(String title, String description, DateTime time, bool isDarkMode) {
    final timeAgo = _getTimeAgo(time);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getActivityIcon(title),
              color: Colors.white70,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  timeAgo,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  IconData _getActivityIcon(String activity) {
    if (activity.toLowerCase().contains('voter')) {
      return Icons.person_add;
    } else if (activity.toLowerCase().contains('election')) {
      return Icons.how_to_vote;
    } else if (activity.toLowerCase().contains('candidate')) {
      return Icons.person;
    } else {
      return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = true;
    final primaryColor = const Color(0xFF6C63FF);
    final secondaryColor = const Color(0xFF42A5F5);
    final accentColor = const Color(0xFF00D2D3);
    final errorColor = const Color(0xFFFF7675);
    final successColor = const Color(0xFF00B894);
    final warningColor = const Color(0xFFFDCB6E);

    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 600;
          final padding = isSmallScreen ? 12.0 : 20.0;
          
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF6C63FF),
                  Color(0xFF42A5F5),
                ],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: isSmallScreen ? 20 : 24,
                            horizontal: isSmallScreen ? 16 : 20
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.07),
                                blurRadius: 18,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(isSmallScreen ? 14 : 16),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.18),
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: isSmallScreen ? 32 : 36,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Welcome back,',
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: isSmallScreen ? 12 : 14,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                'Admin',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: isSmallScreen ? 20 : 24,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 0.5,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (!isSmallScreen) ...[
                                    const SizedBox(width: 16),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.white.withOpacity(0.1),
                                            Colors.white.withOpacity(0.05),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(32),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.white.withOpacity(0.1),
                                            blurRadius: 20,
                                            spreadRadius: 2,
                                            offset: Offset(-5, -5),
                                          ),
                                          BoxShadow(
                                            color: Color(0xFF2D1B69).withOpacity(0.3),
                                            blurRadius: 20,
                                            spreadRadius: 2,
                                            offset: Offset(5, 5),
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.notifications_outlined,
                                            color: Colors.white70,
                                            size: 24,
                                          ),
                                          const SizedBox(width: 12),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF00B894),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: const Text(
                                              '3',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ).animate().fade(duration: 800.ms).scale(duration: 800.ms),
                                  ],
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 20 : 24),
                        _buildContentSections(context, isSmallScreen, isDarkMode),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
} 