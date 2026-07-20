import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../domain/entities/question.dart';
import '../../../domain/entities/question_option.dart';
import '../../providers/admin/question_provider.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_state.dart';

class QuestionBuilderPage extends ConsumerStatefulWidget {
  final String examId;
  const QuestionBuilderPage({super.key, required this.examId});

  @override
  ConsumerState<QuestionBuilderPage> createState() => _QuestionBuilderPageState();
}

class _QuestionBuilderPageState extends ConsumerState<QuestionBuilderPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(questionListProvider.notifier).loadQuestions(widget.examId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(questionListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Question Builder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddQuestionDialog(context),
          ),
        ],
      ),
      body: _buildContent(context, state),
    );
  }

  Widget _buildContent(BuildContext context, QuestionListState state) {
    if (state.status == QuestionListStatus.initial ||
        state.status == QuestionListStatus.loading) {
      return const LoadingIndicator(message: 'Loading questions...');
    }

    if (state.status == QuestionListStatus.error) {
      return ErrorState(
        title: 'Unable to load questions',
        message: state.errorMessage,
        onRetry: () => ref
            .read(questionListProvider.notifier)
            .loadQuestions(widget.examId),
      );
    }

    if (state.questions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.quiz_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('No questions yet'),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _showAddQuestionDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Question'),
            ),
          ],
        ),
      );
    }

    return ReorderableListView(
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final questions = List<Question>.from(state.questions);
        final item = questions.removeAt(oldIndex);
        questions.insert(newIndex, item);
        
        for (int i = 0; i < questions.length; i++) {
          questions[i] = questions[i].copyWith(order: i);
        }
        
        ref.read(questionListProvider.notifier).reorderQuestions(questions);
      },
      children: [
        for (int index = 0; index < state.questions.length; index++)
          _buildQuestionTile(context, state.questions[index], index),
      ],
    );
  }

  Widget _buildQuestionTile(BuildContext context, Question question, int index) {
    return ListTile(
      key: ValueKey(question.id),
      leading: ReorderableDragStartListener(
        index: index,
        child: const Icon(Icons.drag_handle),
      ),
      title: Text('${index + 1}. ${question.questionText}'),
      subtitle: Text('Type: ${question.questionType} • Score: ${question.score}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditQuestionDialog(context, question),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _deleteQuestion(context, question.id),
          ),
        ],
      ),
    );
  }

  void _showAddQuestionDialog(BuildContext context) {
    _showQuestionFormDialog(context, null);
  }

  void _showEditQuestionDialog(BuildContext context, Question question) {
    _showQuestionFormDialog(context, question);
  }

  void _showQuestionFormDialog(BuildContext context, Question? question) {
    showDialog(
      context: context,
      builder: (context) => QuestionFormDialog(
        question: question,
        examId: widget.examId,
        onSave: (question) {
          Navigator.pop(context);
        },
      ),
    );
  }

  void _deleteQuestion(BuildContext context, String questionId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Question'),
        content: const Text('Are you sure you want to delete this question?'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await ref
                  .read(questionDetailProvider.notifier)
                  .deleteQuestion(questionId);
              if (context.mounted) {
                context.pop();
                ref
                    .read(questionListProvider.notifier)
                    .loadQuestions(widget.examId);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class QuestionFormDialog extends StatefulWidget {
  final Question? question;
  final String examId;
  final Function(Question) onSave;

  const QuestionFormDialog({
    super.key,
    this.question,
    required this.examId,
    required this.onSave,
  });

  @override
  State<QuestionFormDialog> createState() => _QuestionFormDialogState();
}

class _QuestionFormDialogState extends State<QuestionFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _questionTextController = TextEditingController();
  final _scoreController = TextEditingController(text: '1');
  String _questionType = 'single_choice';
  final List<QuestionOption> _options = [];
  final List<String> _correctAnswers = [];

  @override
  void initState() {
    super.initState();
    if (widget.question != null) {
      _questionTextController.text = widget.question!.questionText;
      _scoreController.text = widget.question!.score.toString();
      _questionType = widget.question!.questionType;
      _options.addAll(widget.question!.options);
      _correctAnswers.addAll(widget.question!.correctAnswers);
    }
  }

  @override
  void dispose() {
    _questionTextController.dispose();
    _scoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.question == null ? 'Add Question' : 'Edit Question'),
      content: SizedBox(
        width: 600,
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              DropdownButtonFormField<String>(
                value: _questionType,
                decoration: const InputDecoration(
                  labelText: 'Question Type',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'single_choice',
                    child: Text('Single Choice'),
                  ),
                  DropdownMenuItem(
                    value: 'true_false',
                    child: Text('True / False'),
                  ),
                  DropdownMenuItem(
                    value: 'multiple_choice',
                    child: Text('Multiple Choice'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _questionType = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _questionTextController,
                decoration: const InputDecoration(
                  labelText: 'Question',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _scoreController,
                decoration: const InputDecoration(
                  labelText: 'Score',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter score';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              if (_questionType != 'true_false') ...[
                const Text('Options'),
                const SizedBox(height: 8),
                ..._options.asMap().entries.map((entry) {
                  final index = entry.key;
                  final option = entry.value;
                  return ListTile(
                    leading: Radio<String>(
                      value: option.id,
                      groupValue: _correctAnswers.isNotEmpty
                          ? _correctAnswers.first
                          : null,
                      onChanged: (value) {
                        setState(() {
                          _correctAnswers.clear();
                          if (value != null) {
                            _correctAnswers.add(value);
                          }
                        });
                      },
                    ),
                    title: TextFormField(
                      controller: TextEditingController(text: option.text),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      onChanged: (value) {
                        _options[index] = option.copyWith(text: value);
                      },
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _options.removeAt(index);
                        });
                      },
                    ),
                  );
                }),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _options.add(QuestionOption(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        text: '',
                      ));
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Option'),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveQuestion,
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _saveQuestion() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final question = Question(
      id: widget.question?.id ?? '',
      examId: widget.examId,
      questionText: _questionTextController.text.trim(),
      questionType: _questionType,
      options: _options,
      correctAnswers: _correctAnswers,
      score: int.parse(_scoreController.text.trim()),
      order: widget.question?.order ?? 0,
    );

    widget.onSave(question);
  }
}
