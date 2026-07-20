import 'package:easyexam/domain/entities/teacher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('teacher entity preserves its Firestore identity', () {
    const teacher = Teacher(
      id: 'firebase-uid',
      fullName: 'Ayu',
      email: 'ayu@example.com',
    );

    expect(teacher.id, 'firebase-uid');
    expect(teacher.isActive, isTrue);
  });
}
