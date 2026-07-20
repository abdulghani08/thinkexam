import 'base_entity.dart';
import 'class_room.dart';

class ClassPage extends BaseEntity {
  final List<ClassRoom> classes;
  final bool hasMore;
  final String? nextCursor;

  const ClassPage({
    required this.classes,
    this.hasMore = false,
    this.nextCursor,
  });

  @override
  List<Object?> get props => [classes, hasMore, nextCursor];
}
