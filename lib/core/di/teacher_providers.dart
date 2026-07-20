import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_providers.dart';
import '../../data/datasources/firestore_teacher_datasource.dart';
import '../../data/repositories/teacher_repository_impl.dart';
import '../../domain/repositories/teacher_repository.dart';
import '../../domain/usecases/teacher/create_teacher_usecase.dart';
import '../../domain/usecases/teacher/delete_teacher_usecase.dart';
import '../../domain/usecases/teacher/get_teacher_by_id_usecase.dart';
import '../../domain/usecases/teacher/get_teachers_usecase.dart';
import '../../domain/usecases/teacher/search_teachers_usecase.dart';
import '../../domain/usecases/teacher/update_teacher_usecase.dart';

final firestoreTeacherDataSourceProvider = Provider<FirestoreTeacherDataSource>(
  (ref) {
    return FirestoreTeacherDataSource(ref.watch(FirebaseProviders.firestoreProvider));
  },
);

final teacherRepositoryProvider = Provider<TeacherRepository>((ref) {
  return TeacherRepositoryImpl(
    dataSource: ref.watch(firestoreTeacherDataSourceProvider),
  );
});

final createTeacherUseCaseProvider = Provider<CreateTeacherUseCase>(
  (ref) => CreateTeacherUseCase(ref.watch(teacherRepositoryProvider)),
);
final getTeachersUseCaseProvider = Provider<GetTeachersUseCase>(
  (ref) => GetTeachersUseCase(ref.watch(teacherRepositoryProvider)),
);
final getTeacherByIdUseCaseProvider = Provider<GetTeacherByIdUseCase>(
  (ref) => GetTeacherByIdUseCase(ref.watch(teacherRepositoryProvider)),
);
final updateTeacherUseCaseProvider = Provider<UpdateTeacherUseCase>(
  (ref) => UpdateTeacherUseCase(ref.watch(teacherRepositoryProvider)),
);
final deleteTeacherUseCaseProvider = Provider<DeleteTeacherUseCase>(
  (ref) => DeleteTeacherUseCase(ref.watch(teacherRepositoryProvider)),
);
final searchTeachersUseCaseProvider = Provider<SearchTeachersUseCase>(
  (ref) => SearchTeachersUseCase(ref.watch(teacherRepositoryProvider)),
);
