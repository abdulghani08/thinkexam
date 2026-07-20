import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../domain/entities/student.dart';
import '../../providers/admin/student_provider.dart';
import '../../providers/admin/class_provider.dart';

class StudentFormPage extends ConsumerStatefulWidget {
  final String? studentId;
  const StudentFormPage({super.key, this.studentId});

  @override
  ConsumerState<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends ConsumerState<StudentFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _studentNumberController = TextEditingController();
  String? _selectedClassId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.studentId != null) {
      Future.microtask(
        () => ref.read(studentDetailProvider.notifier).loadStudent(widget.studentId!),
      );
    }
    Future.microtask(
      () => ref.read(classListProvider.notifier).loadClasses(),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _studentNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.studentId != null
        ? ref.watch(studentDetailProvider)
        : null;
    final classState = ref.watch(classListProvider);

    if (widget.studentId != null &&
        (state?.status == StudentDetailStatus.initial ||
            state?.status == StudentDetailStatus.loading)) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (widget.studentId != null && state?.student != null) {
      final student = state!.student!;
      _fullNameController.text = student.fullName;
      _emailController.text = student.email;
      _studentNumberController.text = student.studentNumber ?? '';
      _selectedClassId ??= student.classId;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.studentId == null ? 'Add Student' : 'Edit Student'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveStudent,
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
              controller: _fullNameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter full name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _studentNumberController,
              decoration: const InputDecoration(
                labelText: 'Student Number (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Class',
                border: OutlineInputBorder(),
              ),
              value: _selectedClassId,
              items: classState.classes.map((c) =>
                DropdownMenuItem(
                  value: c.id,
                  child: Text(c.className),
                ),
              ).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedClassId = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a class';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveStudent() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final student = Student(
      id: widget.studentId ?? '',
      fullName: _fullNameController.text.trim(),
      email: _emailController.text.trim(),
      studentNumber: _studentNumberController.text.trim().isEmpty
          ? null
          : _studentNumberController.text.trim(),
      classId: _selectedClassId ?? '',
      isActive: true,
    );

    if (widget.studentId != null) {
      await ref.read(studentDetailProvider.notifier).updateStudent(student);
    } else {
      await ref.read(studentDetailProvider.notifier).createStudent(student);
    }

    setState(() => _isLoading = false);

    if (mounted) {
      context.pop();
    }
  }
}
