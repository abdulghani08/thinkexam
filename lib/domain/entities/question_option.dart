import 'base_entity.dart';

/// A single answer option for a question.
class QuestionOption extends BaseEntity {
  final String id;
  final String text;

  const QuestionOption({required this.id, required this.text});

  QuestionOption copyWith({String? text}) =>
      QuestionOption(id: id, text: text ?? this.text);

  @override
  List<Object?> get props => [id, text];
}
