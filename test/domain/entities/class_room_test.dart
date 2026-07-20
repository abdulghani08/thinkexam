import 'package:easyexam/domain/entities/class_room.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ClassRoom Entity', () {
    test('should create class with required fields', () {
      const classRoom = ClassRoom(
        id: 'class-1',
        className: '5A',
        grade: 5,
      );

      expect(classRoom.id, 'class-1');
      expect(classRoom.className, '5A');
      expect(classRoom.grade, 5);
    });

    test('should create class with all fields', () {
      const classRoom = ClassRoom(
        id: 'class-1',
        className: '5A',
        grade: 5,
        homeroomTeacherId: 'teacher-1',
      );

      expect(classRoom.id, 'class-1');
      expect(classRoom.className, '5A');
      expect(classRoom.grade, 5);
      expect(classRoom.homeroomTeacherId, 'teacher-1');
    });

    test('should copy class with new values', () {
      const classRoom = ClassRoom(
        id: 'class-1',
        className: '5A',
        grade: 5,
      );

      final updated = classRoom.copyWith(
        className: '5B',
        homeroomTeacherId: 'teacher-2',
      );

      expect(updated.id, 'class-1');
      expect(updated.className, '5B');
      expect(updated.grade, 5);
      expect(updated.homeroomTeacherId, 'teacher-2');
    });

    test('should implement equality based on props', () {
      const class1 = ClassRoom(
        id: 'class-1',
        className: '5A',
        grade: 5,
      );

      const class2 = ClassRoom(
        id: 'class-1',
        className: '5A',
        grade: 5,
      );

      const class3 = ClassRoom(
        id: 'class-2',
        className: '5A',
        grade: 5,
      );

      expect(class1, equals(class2));
      expect(class1, isNot(equals(class3)));
    });

    test('should handle different grades', () {
      const grade1 = ClassRoom(
        id: 'class-1',
        className: '1A',
        grade: 1,
      );

      const grade6 = ClassRoom(
        id: 'class-2',
        className: '6A',
        grade: 6,
      );

      expect(grade1.grade, 1);
      expect(grade6.grade, 6);
    });
  });
}
