class CandidateModel {
  final String id;
  final String name;
  final String position;
  final String description;
  final String imageUrl;
  final DateTime createdAt;
  final bool isActive;
  int votes;

  CandidateModel({
    required this.id,
    required this.name,
    required this.position,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
    this.isActive = true,
    this.votes = 0,
  });

  factory CandidateModel.fromMap(Map<String, dynamic> map, String id) {
    return CandidateModel(
      id: id,
      name: map['name'] as String,
      position: map['position'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
      createdAt: map['createdAt'] is DateTime 
          ? map['createdAt'] as DateTime 
          : DateTime.parse(map['createdAt'] as String),
      votes: (map['votes'] as num?)?.toInt() ?? 0,
      isActive: map['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'description': description,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'isActive': isActive,
      'votes': votes,
    };
  }

  CandidateModel copyWith({
    String? id,
    String? name,
    String? position,
    String? description,
    String? imageUrl,
    DateTime? createdAt,
    bool? isActive,
    int? votes,
  }) {
    return CandidateModel(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
      votes: votes ?? this.votes,
    );
  }
} 