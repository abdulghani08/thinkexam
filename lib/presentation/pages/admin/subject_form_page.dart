import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../domain/entities/subject.dart';
import '../../providers/admin/subject_provider.dart';

class SubjectFormPage extends ConsumerStatefulWidget {
  final String? subjectId;
  const SubjectFormPage({super.key, this.subjectId});

  @override
  ConsumerState<SubjectFormPage> createState() => _SubjectFormPageState();
}

class _SubjectFormPageState extends ConsumerState<SubjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _subjectNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.subjectId != null) {
      Future.microtask(
        () => ref
            .read(subjectDetailProvider.notifier)
            .loadSubject(widget.subjectId!),
      );
    }
  }

  @override
  void dispose() {
    _subjectNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.subjectId != null
        ? ref.watch(subjectDetailProvider)
        : null;

    if (widget.subjectId != null &&
        (state?.status == SubjectDetailStatus.initial ||
            state?.status == SubjectDetailStatus.loading)) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (widget.subjectId != null && state?.subject != null) {
      final subject = state!.subject!;
      _subjectNameController.text = subject.subjectName;
      _descriptionController.text = subject.description ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subjectId == null ? 'Add Subject' : 'Edit Subject'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveSubject,
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
              controller: _subjectNameController,
              decoration: const InputDecoration(
                labelText: 'Subject Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter subject name';
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
          ],
        ),
      ),
    );
  }

  Future<void> _saveSubject() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final subject = Subject(
      id: widget.subjectId ?? '',
      subjectName: _subjectNameController.text.trim(),
      subjectCode: _subjectNameController.text.trim().toUpperCase().replaceAll(
        ' ',
        '',
      ),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
    );

    if (widget.subjectId != null) {
      await ref.read(subjectDetailProvider.notifier).updateSubject(subject);
    } else {
      await ref.read(subjectDetailProvider.notifier).createSubject(subject);
    }

    setState(() => _isLoading = false);

    if (mounted) {
      context.pop();
    }
  }
}
