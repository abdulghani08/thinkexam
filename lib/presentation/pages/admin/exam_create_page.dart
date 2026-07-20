import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../domain/entities/exam.dart';
import '../../providers/auth/auth_provider.dart';
import '../../providers/admin/exam_provider.dart';
import '../../providers/admin/subject_provider.dart';
import '../../providers/admin/class_provider.dart';

class ExamCreatePage extends ConsumerStatefulWidget {
  const ExamCreatePage({super.key});

  @override
  ConsumerState<ExamCreatePage> createState() => _ExamCreatePageState();
}

class _ExamCreatePageState extends ConsumerState<ExamCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _durationController = TextEditingController(text: '60');
  String? _selectedSubjectId;
  List<String> _selectedClassIds = [];
  bool _randomQuestion = false;
  bool _randomOption = false;
  bool _showResult = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(subjectListProvider.notifier).loadSubjects();
      ref.read(classListProvider.notifier).loadClasses();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subjectState = ref.watch(subjectListProvider);
    final classState = ref.watch(classListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Exam'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveExam,
            child: _isLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Exam Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (Optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(),
              ),
              value: _selectedSubjectId,
              items: subjectState.subjects.map((s) =>
                DropdownMenuItem(
                  value: s.id,
                  child: Text(s.subjectName),
                ),
              ).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSubjectId = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a subject';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _durationController,
              decoration: const InputDecoration(
                labelText: 'Duration (minutes)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter duration';
                }
                final duration = int.tryParse(value);
                if (duration == null || duration < 5) {
                  return 'Duration must be at least 5 minutes';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Target Class',
                border: OutlineInputBorder(),
              ),
              value: _selectedClassIds.isNotEmpty ? _selectedClassIds.first : null,
              items: classState.classes.map((c) =>
                DropdownMenuItem(
                  value: c.id,
                  child: Text(c.className),
                ),
              ).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedClassIds = value != null ? [value] : [];
                });
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Randomize Questions'),
              subtitle: const Text('Shuffle question order for each student'),
              value: _randomQuestion,
              onChanged: (value) {
                setState(() {
                  _randomQuestion = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Randomize Options'),
              subtitle: const Text('Shuffle answer options for each student'),
              value: _randomOption,
              onChanged: (value) {
                setState(() {
                  _randomOption = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Show Results'),
              subtitle: const Text('Allow students to see their results'),
              value: _showResult,
              onChanged: (value) {
                setState(() {
                  _showResult = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveExam() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final authState = ref.read(authProvider);
    final createdBy = authState.user?.id ?? '';

    final exam = Exam(
      id: '',
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      subjectId: _selectedSubjectId!,
      allowedClassIds: _selectedClassIds,
      durationMinutes: int.parse(_durationController.text),
      status: 'draft',
      randomQuestion: _randomQuestion,
      randomOption: _randomOption,
      showResult: _showResult,
      createdBy: createdBy,
    );

    await ref.read(examDetailProvider.notifier).createExam(exam);

    setState(() => _isLoading = false);

    if (mounted) {
      context.pop();
    }
  }
}
