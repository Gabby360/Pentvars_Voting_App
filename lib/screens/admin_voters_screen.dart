import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../services/admin_service.dart';

class AdminVotersScreen extends StatefulWidget {
  const AdminVotersScreen({super.key});

  @override
  State<AdminVotersScreen> createState() => _AdminVotersScreenState();
}

class _AdminVotersScreenState extends State<AdminVotersScreen> {
  final _adminService = AdminService();
  List<Map<String, dynamic>> _voters = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadVoters();
  }

  Future<void> _loadVoters() async {
    setState(() => _isLoading = true);
    try {
      final voters = await _adminService.getVoters();
      setState(() {
        _voters = voters;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading voters: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _exportVoters() async {
    try {
      final List<List<dynamic>> csvData = [
        ['ID', 'Name', 'Email', 'Student ID', 'Eligibility Status', 'Voted'],
        ..._voters.map((voter) => [
              voter['id'],
              voter['name'],
              voter['email'],
              voter['studentId'],
              voter['isEligible'] ? 'Eligible' : 'Not Eligible',
              voter['hasVoted'] ? 'Yes' : 'No',
            ]),
      ];

      final String csv = const ListToCsvConverter().convert(csvData);
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/voters.csv');
      await file.writeAsString(csv);

      if (mounted) {
        await Share.shareXFiles([XFile(file.path)]);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error exporting voters: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _toggleEligibility(String voterId, bool isEligible) async {
    try {
      await _adminService.updateVoterEligibility(voterId, isEligible);
      await _loadVoters();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Voter eligibility ${isEligible ? 'approved' : 'rejected'}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating eligibility: ${e.toString()}')),
        );
      }
    }
  }

  List<Map<String, dynamic>> get _filteredVoters {
    if (_searchQuery.isEmpty) return _voters;
    return _voters.where((voter) {
      final name = voter['name'].toString().toLowerCase();
      final email = voter['email'].toString().toLowerCase();
      final studentId = voter['studentId'].toString().toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query) || email.contains(query) || studentId.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search voters...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => setState(() => _searchQuery = value),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _exportVoters,
                  icon: const Icon(Icons.download),
                  label: const Text('Export'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _filteredVoters.length,
                    itemBuilder: (context, index) {
                      final voter = _filteredVoters[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text(voter['name']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(voter['email']),
                              Text('Student ID: ${voter['studentId']}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  voter['isEligible'] ? Icons.check_circle : Icons.cancel,
                                  color: voter['isEligible'] ? Colors.green : Colors.red,
                                ),
                                onPressed: () => _toggleEligibility(
                                  voter['id'],
                                  !voter['isEligible'],
                                ),
                                tooltip: voter['isEligible']
                                    ? 'Mark as ineligible'
                                    : 'Mark as eligible',
                              ),
                              if (voter['hasVoted'])
                                const Icon(
                                  Icons.how_to_vote,
                                  color: Colors.green,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
} 