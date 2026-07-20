import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';
import '../../../domain/entities/class_room.dart';
import '../../providers/admin/class_provider.dart';
import '../../providers/teacher/teacher_provider.dart';

class ClassFormPage extends ConsumerStatefulWidget {
  final String? classId;
  const ClassFormPage({super.key, this.classId});

  @override
  ConsumerState<ClassFormPage> createState() => _ClassFormPageState();
}

class _ClassFormPageState extends ConsumerState<ClassFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _classNameController = TextEditingController();
  final _gradeController = TextEditingController();
  String? _selectedHomeroomTeacherId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.classId != null) {
      Future.microtask(
        () => ref.read(classDetailProvider.notifier).loadClass(widget.classId!),
      );
    }
    Future.microtask(
      () => ref.read(teacherListProvider.notifier).loadTeachers(),
    );
  }

  @override
  void dispose() {
    _classNameController.dispose();
    _gradeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detailState = widget.classId != null
        ? ref.watch(classDetailProvider)
        : null;
    final teacherState = ref.watch(teacherListProvider);

    if (widget.classId != null &&
        (detailState?.status == ClassDetailStatus.initial ||
            detailState?.status == ClassDetailStatus.loading)) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (widget.classId != null && detailState?.classRoom != null) {
      final classRoom = detailState!.classRoom!;
      _classNameController.text = classRoom.className;
      _gradeController.text = classRoom.grade.toString();
      _selectedHomeroomTeacherId ??= classRoom.homeroomTeacherId;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.classId == null ? 'Add Class' : 'Edit Class'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveClass,
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
              controller: _classNameController,
              decoration: const InputDecoration(
                labelText: 'Class Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter class name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _gradeController,
              decoration: const InputDecoration(
                labelText: 'Grade',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter grade';
                }
                final grade = int.tryParse(value);
                if (grade == null || grade < 1 || grade > 12) {
                  return 'Grade must be between 1 and 12';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Homeroom Teacher (Optional)',
                border: OutlineInputBorder(),
              ),
              value: _selectedHomeroomTeacherId,
              items: [
                const DropdownMenuItem(value: null, child: Text('None')),
                ...?teacherState.teachers.map(
                  (teacher) => DropdownMenuItem(
                    value: teacher.id,
                    child: Text(teacher.fullName),
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedHomeroomTeacherId = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveClass() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final classRoom = ClassRoom(
      id: widget.classId ?? '',
      className: _classNameController.text.trim(),
      grade: int.parse(_gradeController.text.trim()),
      academicYear: DateTime.now().year.toString(),
      homeroomTeacherId: _selectedHomeroomTeacherId,
    );

    if (widget.classId != null) {
      await ref.read(classDetailProvider.notifier).updateClass(classRoom);
    } else {
      await ref.read(classDetailProvider.notifier).createClass(classRoom);
    }

    setState(() => _isLoading = false);

    if (mounted) {
      context.pop();
    }
  }
}
