import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/question_option.dart';

/// Shared Firestore helpers for question option serialization.
class QuestionOptionMapper {
  QuestionOptionMapper._();

  static List<QuestionOption> fromFirestoreList(List<dynamic>? raw) {
    if (raw == null) return [];
    return raw.map((item) {
      final map = Map<String, dynamic>.from(item as Map);
      return QuestionOption(
        id: map['id'] as String? ?? '',
        text: map['text'] as String? ?? '',
      );
    }).toList();
  }

  static List<Map<String, dynamic>> toFirestoreList(List<QuestionOption> options) {
    return options
        .map((option) => {'id': option.id, 'text': option.text})
        .toList();
  }

  static List<String> answersFromFirestore(dynamic raw) {
    if (raw == null) return [];
    if (raw is List) return raw.map((e) => e.toString()).toList();
    return [raw.toString()];
  }

  static dynamic answersToFirestore(List<String> answers) {
    if (answers.length <= 1) return answers.isEmpty ? '' : answers.first;
    return answers;
  }
}
