import 'dart:async';
import '../models/candidate_model.dart';
import '../models/user_model.dart';

class AdminService {
  // Admin credentials (in a real app, these should be stored securely in a database)
  static const Map<String, String> _adminCredentials = {
    'admin@pentvars.edu.gh': 'Admin@123',
    'supervisor@pentvars.edu.gh': 'Supervisor@123',
  };

  // In-memory storage for candidates
  final List<CandidateModel> _candidates = [];
  bool _isElectionActive = false;
  String? _currentAdminEmail;

  // Stream controllers
  final _candidatesController = StreamController<List<CandidateModel>>.broadcast();
  final _electionStatusController = StreamController<bool>.broadcast();
  final _adminAuthController = StreamController<bool>.broadcast();

  // Getters for streams
  Stream<List<CandidateModel>> get candidatesStream => _candidatesController.stream;
  Stream<bool> get electionStatusStream => _electionStatusController.stream;
  Stream<bool> get isAdminAuthenticated => _adminAuthController.stream;

  AdminService() {
    // Initialize streams
    _candidatesController.add(_candidates);
    _electionStatusController.add(_isElectionActive);
    _adminAuthController.add(false);
  }

  // Admin authentication
  Future<bool> login(String email, String password) async {
    print('AdminService: Login attempt with email: $email'); // Debug print
    
    try {
      // Temporarily bypass authentication
      _currentAdminEmail = email;
      print('AdminService: Setting current admin email to: $_currentAdminEmail'); // Debug print
      
      _adminAuthController.add(true);
      print('AdminService: Authentication state updated to true'); // Debug print
      
      return true;
    } catch (e) {
      print('AdminService: Error during login: $e'); // Debug print
      return false;
    }
  }

  // Logout admin
  Future<void> logout() async {
    _currentAdminEmail = null;
    _adminAuthController.add(false);
  }

  // Check if admin is logged in
  bool isAdminLoggedIn() {
    return _currentAdminEmail != null;
  }

  // Get current admin email
  String? getCurrentAdminEmail() {
    return _currentAdminEmail;
  }

  // Add a new candidate
  Future<void> addCandidate(CandidateModel candidate) async {
    if (!isAdminLoggedIn()) {
      throw Exception('Unauthorized: Please log in as admin');
    }

    _candidates.add(candidate);
    _candidatesController.add(List.from(_candidates));
  }

  // Delete a candidate
  Future<void> deleteCandidate(String candidateId) async {
    if (!isAdminLoggedIn()) {
      throw Exception('Unauthorized: Please log in as admin');
    }

    _candidates.removeWhere((c) => c.id == candidateId);
    _candidatesController.add(List.from(_candidates));
  }

  // Update a candidate
  Future<void> updateCandidate(String candidateId, CandidateModel candidate) async {
    if (!isAdminLoggedIn()) {
      throw Exception('Unauthorized: Please log in as admin');
    }

    final index = _candidates.indexWhere((c) => c.id == candidateId);
    if (index != -1) {
      _candidates[index] = candidate;
      _candidatesController.add(List.from(_candidates));
    }
  }

  // Get all candidates (for admin view)
  Stream<List<CandidateModel>> getAllCandidates() {
    return _candidatesController.stream;
  }

  // Get live vote counts
  Stream<List<CandidateModel>> getLiveVoteCounts() {
    return _candidatesController.stream.map((candidates) => 
      candidates.where((c) => c.isActive).toList()
    );
  }

  // Reset election (clear all votes)
  Future<void> resetElection() async {
    if (!isAdminLoggedIn()) {
      throw Exception('Unauthorized: Please log in as admin');
    }

    for (var candidate in _candidates) {
      candidate.votes = 0;
    }
    _candidatesController.add(List.from(_candidates));
  }

  // End election (mark all candidates as inactive)
  Future<void> endElection() async {
    if (!isAdminLoggedIn()) {
      throw Exception('Unauthorized: Please log in as admin');
    }

    _isElectionActive = false;
    _electionStatusController.add(_isElectionActive);
  }

  // Start election (mark all candidates as active)
  Future<void> startElection() async {
    if (!isAdminLoggedIn()) {
      throw Exception('Unauthorized: Please log in as admin');
    }

    _isElectionActive = true;
    _electionStatusController.add(_isElectionActive);
  }

  // Check if election is active
  bool isElectionActive() {
    return _isElectionActive;
  }

  // Dispose streams
  void dispose() {
    _candidatesController.close();
    _electionStatusController.close();
    _adminAuthController.close();
  }

  Future<List<CandidateModel>> getCandidates() async {
    return List.from(_candidates);
  }

  Future<int> getTotalVotes() async {
    int total = 0;
    for (var candidate in _candidates) {
      total += candidate.votes;
    }
    return total;
  }

  Future<List<Map<String, dynamic>>> getVoters() async {
    // In a real app, this would return actual voter data
    return [];
  }

  Future<void> updateVoterEligibility(String voterId, bool isEligible) async {
    // In a real app, this would update voter eligibility
  }

  Future<Map<String, dynamic>> getSettings() async {
    return {
      'isActive': _isElectionActive,
      'totalVotes': await getTotalVotes(),
    };
  }

  Future<void> updateSettings(Map<String, dynamic> settings) async {
    if (settings.containsKey('isActive')) {
      _isElectionActive = settings['isActive'];
      _electionStatusController.add(_isElectionActive);
    }
  }
} 