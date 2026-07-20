import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/class_room.dart';
import '../../../domain/entities/class_page.dart';
import '../../../domain/repositories/class_repository.dart';
import '../../../core/di/class_providers.dart';
import '../../../domain/usecases/class/create_class_usecase.dart';
import '../../../domain/usecases/class/delete_class_usecase.dart';
import '../../../domain/usecases/class/get_class_by_id_usecase.dart';
import '../../../domain/usecases/class/get_classes_usecase.dart';
import '../../../domain/usecases/class/search_classes_usecase.dart';
import '../../../domain/usecases/class/update_class_usecase.dart';

enum ClassListStatus { initial, loading, success, error }

class ClassListState {
  final ClassListStatus status;
  final List<ClassRoom> classes;
  final String? errorMessage;
  final bool hasMore;
  final String? nextCursor;
  final String? currentQuery;

  const ClassListState({
    this.status = ClassListStatus.initial,
    this.classes = const [],
    this.errorMessage,
    this.hasMore = false,
    this.nextCursor,
    this.currentQuery,
  });

  ClassListState copyWith({
    ClassListStatus? status,
    List<ClassRoom>? classes,
    String? errorMessage,
    bool? hasMore,
    String? nextCursor,
    String? currentQuery,
  }) => ClassListState(
    status: status ?? this.status,
    classes: classes ?? this.classes,
    errorMessage: errorMessage ?? this.errorMessage,
    hasMore: hasMore ?? this.hasMore,
    nextCursor: nextCursor ?? this.nextCursor,
    currentQuery: currentQuery ?? this.currentQuery,
  );
}

class ClassListNotifier extends StateNotifier<ClassListState> {
  final GetClassesUseCase _getClassesUseCase;
  final SearchClassesUseCase _searchClassesUseCase;

  ClassListNotifier(this._getClassesUseCase, this._searchClassesUseCase)
    : super(const ClassListState());

  Future<void> loadClasses({bool refresh = false}) async {
    if (refresh) {
      state = state.copyWith(
        status: ClassListStatus.loading,
        classes: [],
        nextCursor: null,
      );
    } else if (state.status == ClassListStatus.loading) {
      return;
    }

    final result = await _getClassesUseCase(
      GetClassesParams(cursor: refresh ? null : state.nextCursor, limit: 20),
    );

    result.fold(
      (failure) => state = state.copyWith(
        status: ClassListStatus.error,
        errorMessage: failure.message,
      ),
      (page) => state = state.copyWith(
        status: ClassListStatus.success,
        classes: refresh ? page.classes : [...state.classes, ...page.classes],
        hasMore: page.hasMore,
        nextCursor: page.nextCursor,
      ),
    );
  }

  Future<void> searchClasses(String query) async {
    state = state.copyWith(
      status: ClassListStatus.loading,
      classes: [],
      nextCursor: null,
      currentQuery: query,
    );

    final result = await _searchClassesUseCase(
      SearchClassesParams(query: query, limit: 20),
    );

    result.fold(
      (failure) => state = state.copyWith(
        status: ClassListStatus.error,
        errorMessage: failure.message,
      ),
      (page) => state = state.copyWith(
        status: ClassListStatus.success,
        classes: page.classes,
        hasMore: page.hasMore,
        nextCursor: page.nextCursor,
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.status == ClassListStatus.loading) return;

    if (state.currentQuery != null && state.currentQuery!.isNotEmpty) {
      final result = await _searchClassesUseCase(
        SearchClassesParams(
          query: state.currentQuery!,
          cursor: state.nextCursor,
          limit: 20,
        ),
      );

      result.fold(
        (failure) => state = state.copyWith(
          status: ClassListStatus.error,
          errorMessage: failure.message,
        ),
        (page) => state = state.copyWith(
          status: ClassListStatus.success,
          classes: [...state.classes, ...page.classes],
          hasMore: page.hasMore,
          nextCursor: page.nextCursor,
        ),
      );
    } else {
      await loadClasses();
    }
  }
}

enum ClassDetailStatus { initial, loading, success, error }

class ClassDetailState {
  final ClassDetailStatus status;
  final ClassRoom? classRoom;
  final String? errorMessage;

  const ClassDetailState({
    this.status = ClassDetailStatus.initial,
    this.classRoom,
    this.errorMessage,
  });

  ClassDetailState copyWith({
    ClassDetailStatus? status,
    ClassRoom? classRoom,
    String? errorMessage,
  }) => ClassDetailState(
    status: status ?? this.status,
    classRoom: classRoom ?? this.classRoom,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}

class ClassDetailNotifier extends StateNotifier<ClassDetailState> {
  final GetClassByIdUseCase _getClassByIdUseCase;
  final CreateClassUseCase _createClassUseCase;
  final UpdateClassUseCase _updateClassUseCase;
  final DeleteClassUseCase _deleteClassUseCase;

  ClassDetailNotifier(
    this._getClassByIdUseCase,
    this._createClassUseCase,
    this._updateClassUseCase,
    this._deleteClassUseCase,
  ) : super(const ClassDetailState());

  Future<void> loadClass(String id) async {
    state = state.copyWith(status: ClassDetailStatus.loading);
    final result = await _getClassByIdUseCase(GetClassByIdParams(id));
    result.fold(
      (failure) => state = state.copyWith(
        status: ClassDetailStatus.error,
        errorMessage: failure.message,
      ),
      (classRoom) => state = state.copyWith(
        status: ClassDetailStatus.success,
        classRoom: classRoom,
      ),
    );
  }

  Future<void> createClass(ClassRoom classRoom) async {
    final result = await _createClassUseCase(classRoom);
    result.fold(
      (failure) => state = state.copyWith(
        status: ClassDetailStatus.error,
        errorMessage: failure.message,
      ),
      (created) => state = state.copyWith(
        status: ClassDetailStatus.success,
        classRoom: created,
      ),
    );
  }

  Future<void> updateClass(ClassRoom classRoom) async {
    final result = await _updateClassUseCase(classRoom);
    result.fold(
      (failure) => state = state.copyWith(
        status: ClassDetailStatus.error,
        errorMessage: failure.message,
      ),
      (updated) => state = state.copyWith(
        status: ClassDetailStatus.success,
        classRoom: updated,
      ),
    );
  }

  Future<void> deleteClass(String id) async {
    final result = await _deleteClassUseCase(DeleteClassParams(id));
    return result.fold(
      (failure) => state = state.copyWith(
        status: ClassDetailStatus.error,
        errorMessage: failure.message,
      ),
      (_) => state = state.copyWith(status: ClassDetailStatus.success),
    );
  }
}

final classListProvider =
    StateNotifierProvider<ClassListNotifier, ClassListState>((ref) {
      final classRepository = ref.watch(classRepositoryProvider);
      final getClassesUseCase = GetClassesUseCase(classRepository);
      final searchClassesUseCase = SearchClassesUseCase(classRepository);
      return ClassListNotifier(getClassesUseCase, searchClassesUseCase);
    });

final classDetailProvider =
    StateNotifierProvider<ClassDetailNotifier, ClassDetailState>((ref) {
      final classRepository = ref.watch(classRepositoryProvider);
      final getClassByIdUseCase = GetClassByIdUseCase(classRepository);
      final createClassUseCase = CreateClassUseCase(classRepository);
      final updateClassUseCase = UpdateClassUseCase(classRepository);
      final deleteClassUseCase = DeleteClassUseCase(classRepository);
      return ClassDetailNotifier(
        getClassByIdUseCase,
        createClassUseCase,
        updateClassUseCase,
        deleteClassUseCase,
      );
    });
