import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../services/admin_service.dart';
import '../models/candidate_model.dart';

class AdminResultsScreen extends StatefulWidget {
  const AdminResultsScreen({super.key});

  @override
  State<AdminResultsScreen> createState() => _AdminResultsScreenState();
}

class _AdminResultsScreenState extends State<AdminResultsScreen> {
  final _adminService = AdminService();
  List<CandidateModel> _candidates = [];
  bool _isLoading = true;
  Map<String, int> _positionVotes = {};
  int _totalVotes = 0;

  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  Future<void> _loadResults() async {
    setState(() => _isLoading = true);
    try {
      final candidates = await _adminService.getCandidates();
      final totalVotes = await _adminService.getTotalVotes();
      
      // Calculate votes by position
      final positionVotes = <String, int>{};
      for (var candidate in candidates) {
        positionVotes[candidate.position] = 
            (positionVotes[candidate.position] ?? 0) + candidate.votes.toInt();
      }

      setState(() {
        _candidates = candidates;
        _positionVotes = positionVotes;
        _totalVotes = totalVotes.toInt();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading results: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _exportResults() async {
    try {
      final List<List<dynamic>> csvData = [
        ['Position', 'Candidate', 'Votes', 'Percentage'],
        ..._candidates.map((candidate) => [
              candidate.position,
              candidate.name,
              candidate.votes,
              _totalVotes > 0
                  ? '${((candidate.votes / _totalVotes) * 100).toStringAsFixed(2)}%'
                  : '0%',
            ]),
      ];

      final String csv = const ListToCsvConverter().convert(csvData);
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/election_results.csv');
      await file.writeAsString(csv);

      if (mounted) {
        await Share.shareXFiles([XFile(file.path)]);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error exporting results: ${e.toString()}')),
        );
      }
    }
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
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text(
                            'Total Votes',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _totalVotes.toString(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _exportResults,
                  icon: const Icon(Icons.download),
                  label: const Text('Export Results'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const TabBar(
                          tabs: [
                            Tab(text: 'By Position'),
                            Tab(text: 'All Candidates'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              // By Position Tab
                              ListView.builder(
                                itemCount: _positionVotes.length,
                                itemBuilder: (context, index) {
                                  final position = _positionVotes.keys.elementAt(index);
                                  final votes = _positionVotes[position]!;
                                  final candidates = _candidates
                                      .where((c) => c.position == position)
                                      .toList()
                                    ..sort((a, b) => b.votes.compareTo(a.votes));

                                  return Card(
                                    margin: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Text(
                                            position,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        ...candidates.map((candidate) => ListTile(
                                              title: Text(candidate.name),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    '${candidate.votes} votes',
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    _totalVotes > 0
                                                        ? '${((candidate.votes / _totalVotes) * 100).toStringAsFixed(1)}%'
                                                        : '0%',
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              // All Candidates Tab
                              ListView.builder(
                                itemCount: _candidates.length,
                                itemBuilder: (context, index) {
                                  final candidate = _candidates[index];
                                  return Card(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    child: ListTile(
                                      title: Text(candidate.name),
                                      subtitle: Text(candidate.position),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            '${candidate.votes} votes',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            _totalVotes > 0
                                                ? '${((candidate.votes / _totalVotes) * 100).toStringAsFixed(1)}%'
                                                : '0%',
                                            style: const TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
} 