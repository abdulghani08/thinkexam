import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/question.dart';
import '../../../domain/entities/question_bank_page.dart';
import '../../../domain/repositories/question_repository.dart';
import '../../../core/di/question_providers.dart';
import '../../../domain/usecases/question/create_question_usecase.dart';
import '../../../domain/usecases/question/delete_question_usecase.dart';
import '../../../domain/usecases/question/get_question_by_id_usecase.dart';
import '../../../domain/usecases/question/get_questions_by_exam_usecase.dart';
import '../../../domain/usecases/question/reorder_questions_usecase.dart';
import '../../../domain/usecases/question/update_question_usecase.dart';

enum QuestionListStatus { initial, loading, success, error }

class QuestionListState {
  final QuestionListStatus status;
  final List<Question> questions;
  final String? errorMessage;
  final bool hasMore;
  final String? nextCursor;
  final String examId;

  const QuestionListState({
    this.status = QuestionListStatus.initial,
    this.questions = const [],
    this.errorMessage,
    this.hasMore = false,
    this.nextCursor,
    required this.examId,
  });

  QuestionListState copyWith({
    QuestionListStatus? status,
    List<Question>? questions,
    String? errorMessage,
    bool? hasMore,
    String? nextCursor,
  }) => QuestionListState(
    status: status ?? this.status,
    questions: questions ?? this.questions,
    errorMessage: errorMessage ?? this.errorMessage,
    hasMore: hasMore ?? this.hasMore,
    nextCursor: nextCursor ?? this.nextCursor,
    examId: examId,
  );
}

class QuestionListNotifier extends StateNotifier<QuestionListState> {
  final GetQuestionsByExamUseCase _getQuestionsByExamUseCase;
  final ReorderQuestionsUseCase _reorderQuestionsUseCase;

  QuestionListNotifier(
    this._getQuestionsByExamUseCase,
    this._reorderQuestionsUseCase,
  ) : super(const QuestionListState(examId: ''));

  Future<void> loadQuestions(String examId, {bool refresh = false}) async {
    state = QuestionListState(
      examId: examId,
      status: QuestionListStatus.loading,
    );

    final result = await _getQuestionsByExamUseCase(
      GetQuestionsByExamParams(examId: examId, limit: 100),
    );

    result.fold(
      (failure) => state = state.copyWith(
        status: QuestionListStatus.error,
        errorMessage: failure.message,
      ),
      (page) => state = state.copyWith(
        status: QuestionListStatus.success,
        questions: page.questions,
        hasMore: page.hasMore,
        nextCursor: page.nextCursor,
      ),
    );
  }

  Future<void> reorderQuestions(List<Question> questions) async {
    final result = await _reorderQuestionsUseCase(
      ReorderQuestionsParams(questions),
    );
    result.fold(
      (failure) => state = state.copyWith(
        status: QuestionListStatus.error,
        errorMessage: failure.message,
      ),
      (_) => state = state.copyWith(
        status: QuestionListStatus.success,
        questions: questions,
      ),
    );
  }
}

enum QuestionDetailStatus { initial, loading, success, error }

class QuestionDetailState {
  final QuestionDetailStatus status;
  final Question? question;
  final String? errorMessage;

  const QuestionDetailState({
    this.status = QuestionDetailStatus.initial,
    this.question,
    this.errorMessage,
  });

  QuestionDetailState copyWith({
    QuestionDetailStatus? status,
    Question? question,
    String? errorMessage,
  }) => QuestionDetailState(
    status: status ?? this.status,
    question: question ?? this.question,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}

class QuestionDetailNotifier extends StateNotifier<QuestionDetailState> {
  final GetQuestionByIdUseCase _getQuestionByIdUseCase;
  final UpdateQuestionUseCase _updateQuestionUseCase;
  final DeleteQuestionUseCase _deleteQuestionUseCase;

  QuestionDetailNotifier(
    this._getQuestionByIdUseCase,
    this._updateQuestionUseCase,
    this._deleteQuestionUseCase,
  ) : super(const QuestionDetailState());

  Future<void> loadQuestion(String id) async {
    state = state.copyWith(status: QuestionDetailStatus.loading);
    final result = await _getQuestionByIdUseCase(GetQuestionByIdParams(id));
    result.fold(
      (failure) => state = state.copyWith(
        status: QuestionDetailStatus.error,
        errorMessage: failure.message,
      ),
      (question) => state = state.copyWith(
        status: QuestionDetailStatus.success,
        question: question,
      ),
    );
  }

  Future<void> updateQuestion(Question question) async {
    final result = await _updateQuestionUseCase(question);
    result.fold(
      (failure) => state = state.copyWith(
        status: QuestionDetailStatus.error,
        errorMessage: failure.message,
      ),
      (updated) => state = state.copyWith(
        status: QuestionDetailStatus.success,
        question: updated,
      ),
    );
  }

  Future<void> deleteQuestion(String id) async {
    final result = await _deleteQuestionUseCase(DeleteQuestionParams(id));
    return result.fold(
      (failure) => state = state.copyWith(
        status: QuestionDetailStatus.error,
        errorMessage: failure.message,
      ),
      (_) => state = state.copyWith(status: QuestionDetailStatus.success),
    );
  }
}

final questionListProvider =
    StateNotifierProvider<QuestionListNotifier, QuestionListState>((ref) {
      final questionRepository = ref.watch(questionRepositoryProvider);
      final getQuestionsByExamUseCase = GetQuestionsByExamUseCase(
        questionRepository,
      );
      final reorderQuestionsUseCase = ReorderQuestionsUseCase(
        questionRepository,
      );
      return QuestionListNotifier(
        getQuestionsByExamUseCase,
        reorderQuestionsUseCase,
      );
    });

final questionDetailProvider =
    StateNotifierProvider<QuestionDetailNotifier, QuestionDetailState>((ref) {
      final questionRepository = ref.watch(questionRepositoryProvider);
      final getQuestionByIdUseCase = GetQuestionByIdUseCase(questionRepository);
      final updateQuestionUseCase = UpdateQuestionUseCase(questionRepository);
      final deleteQuestionUseCase = DeleteQuestionUseCase(questionRepository);
      return QuestionDetailNotifier(
        getQuestionByIdUseCase,
        updateQuestionUseCase,
        deleteQuestionUseCase,
      );
    });
