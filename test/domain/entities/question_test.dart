import 'package:easyexam/domain/entities/question.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Question Entity', () {
    test('should create question with required fields', () {
      const question = Question(
        id: 'question-1',
        examId: 'exam-1',
        questionText: 'What is 2 + 2?',
        options: ['3', '4', '5', '6'],
        correctAnswer: '4',
        score: 1,
      );

      expect(question.id, 'question-1');
      expect(question.examId, 'exam-1');
      expect(question.questionText, 'What is 2 + 2?');
      expect(question.options, ['3', '4', '5', '6']);
      expect(question.correctAnswer, '4');
      expect(question.score, 1);
    });

    test('should create question with all fields', () {
      const question = Question(
        id: 'question-1',
        examId: 'exam-1',
        questionText: 'What is 2 + 2?',
        questionImage: 'https://example.com/image.jpg',
        options: ['3', '4', '5', '6'],
        correctAnswer: '4',
        explanation: '2 + 2 = 4',
        score: 2,
        order: 1,
      );

      expect(question.id, 'question-1');
      expect(question.questionImage, 'https://example.com/image.jpg');
      expect(question.explanation, '2 + 2 = 4');
      expect(question.score, 2);
      expect(question.order, 1);
    });

    test('should copy question with new values', () {
      const question = Question(
        id: 'question-1',
        examId: 'exam-1',
        questionText: 'What is 2 + 2?',
        options: ['3', '4', '5', '6'],
        correctAnswer: '4',
        score: 1,
      );

      final updated = question.copyWith(
        questionText: 'What is 3 + 3?',
        score: 2,
      );

      expect(updated.id, 'question-1');
      expect(updated.questionText, 'What is 3 + 3?');
      expect(updated.score, 2);
    });

    test('should preserve original when copying with null values', () {
      const question = Question(
        id: 'question-1',
        examId: 'exam-1',
        questionText: 'What is 2 + 2?',
        options: ['3', '4', '5', '6'],
        correctAnswer: '4',
        score: 1,
      );

      final copied = question.copyWith();

      expect(copied.id, question.id);
      expect(copied.questionText, question.questionText);
      expect(copied.score, question.score);
    });

    test('should implement equality based on props', () {
      const question1 = Question(
        id: 'question-1',
        examId: 'exam-1',
        questionText: 'What is 2 + 2?',
        options: ['3', '4', '5', '6'],
        correctAnswer: '4',
        score: 1,
      );

      const question2 = Question(
        id: 'question-1',
        examId: 'exam-1',
        questionText: 'What is 2 + 2?',
        options: ['3', '4', '5', '6'],
        correctAnswer: '4',
        score: 1,
      );

      const question3 = Question(
        id: 'question-2',
        examId: 'exam-1',
        questionText: 'What is 2 + 2?',
        options: ['3', '4', '5', '6'],
        correctAnswer: '4',
        score: 1,
      );

      expect(question1, equals(question2));
      expect(question1, isNot(equals(question3)));
    });

    test('should handle different question types', () {
      const multipleChoice = Question(
        id: 'question-1',
        examId: 'exam-1',
        questionText: 'What is 2 + 2?',
        options: ['3', '4', '5', '6'],
        correctAnswer: '4',
        score: 1,
      );

      const trueFalse = Question(
        id: 'question-2',
        examId: 'exam-1',
        questionText: 'Earth is flat',
        options: ['True', 'False'],
        correctAnswer: 'False',
        score: 1,
      );

      expect(multipleChoice.options.length, 4);
      expect(trueFalse.options.length, 2);
    });

    test('should handle question with image', () {
      const question = Question(
        id: 'question-1',
        examId: 'exam-1',
        questionText: 'What is in this image?',
        questionImage: 'https://example.com/image.jpg',
        options: ['A', 'B', 'C', 'D'],
        correctAnswer: 'A',
        score: 1,
      );

      expect(question.questionImage, 'https://example.com/image.jpg');
    });

    test('should handle question explanation', () {
      const question = Question(
        id: 'question-1',
        examId: 'exam-1',
        questionText: 'What is 2 + 2?',
        options: ['3', '4', '5', '6'],
        correctAnswer: '4',
        explanation: 'Basic arithmetic: 2 + 2 = 4',
        score: 1,
      );

      expect(question.explanation, 'Basic arithmetic: 2 + 2 = 4');
    });
  });
}
