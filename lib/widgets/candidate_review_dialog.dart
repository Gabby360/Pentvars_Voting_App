import 'package:flutter/material.dart';

class CandidateReviewDialog extends StatelessWidget {
  final Map<String, dynamic> candidateDetails;
  final String category;
  final VoidCallback onConfirm;
  final VoidCallback onEdit;

  const CandidateReviewDialog({
    super.key,
    required this.candidateDetails,
    required this.category,
    required this.onConfirm,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Review Your Selection'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[200],
            child: candidateDetails["image"] != null
                ? ClipOval(
                    child: Image.asset(
                      candidateDetails["image"]!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey,
                        );
                      },
                    ),
                  )
                : const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.grey,
                  ),
          ),
          const SizedBox(height: 16),
          Text(
            candidateDetails["name"]!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(candidateDetails["bio"]!),
          const SizedBox(height: 16),
          Text('Category: $category'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onEdit,
          child: const Text('Edit'),
        ),
        TextButton(
          onPressed: onConfirm,
          child: const Text('Confirm'),
        ),
      ],
    );
  }
} 