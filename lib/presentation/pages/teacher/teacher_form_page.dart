import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/validators.dart';
import '../../../domain/entities/teacher.dart';
import '../../providers/teacher/teacher_provider.dart';
import '../../widgets/common/error_state.dart';
import '../../widgets/common/loading_indicator.dart';

class TeacherFormPage extends ConsumerStatefulWidget {
  final String? teacherId;
  const TeacherFormPage({super.key, this.teacherId});
  bool get isEditing => teacherId != null;

  @override
  ConsumerState<TeacherFormPage> createState() => _TeacherFormPageState();
}

class _TeacherFormPageState extends ConsumerState<TeacherFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _photoUrlController = TextEditingController();
  bool _isActive = true;
  bool _saving = false;

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _photoUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isEditing) return _buildScaffold(context);
    return ref
        .watch(teacherDetailProvider(widget.teacherId!))
        .when(
          loading: () => const Scaffold(
            body: LoadingIndicator(message: 'Loading teacher...'),
          ),
          error: (error, _) => Scaffold(
            body: ErrorState(
              title: 'Unable to load teacher',
              message: error.toString(),
            ),
          ),
          data: (teacher) {
            _populate(teacher);
            return _buildScaffold(context);
          },
        );
  }

  void _populate(Teacher teacher) {
    if (_idController.text.isNotEmpty) return;
    _idController.text = teacher.id;
    _nameController.text = teacher.fullName;
    _emailController.text = teacher.email;
    _photoUrlController.text = teacher.photoUrl ?? '';
    _isActive = teacher.isActive;
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit teacher' : 'Add teacher'),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  TextFormField(
                    controller: _idController,
                    enabled: !widget.isEditing,
                    validator: (value) => Validators.validateRequired(
                      value,
                      fieldName: 'Firebase User ID',
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Firebase User ID',
                      prefixIcon: Icon(Icons.key_outlined),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    textCapitalization: TextCapitalization.words,
                    validator: (value) => Validators.validateRequired(
                      value,
                      fieldName: 'Full name',
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Full name',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.validateEmail,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _photoUrlController,
                    keyboardType: TextInputType.url,
                    decoration: const InputDecoration(
                      labelText: 'Photo URL (optional)',
                      prefixIcon: Icon(Icons.image_outlined),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Active account'),
                    value: _isActive,
                    onChanged: (value) => setState(() => _isActive = value),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: _saving ? null : _submit,
                    icon: _saving
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save_outlined),
                    label: Text(_saving ? 'Saving...' : 'Save teacher'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final teacher = Teacher(
      id: _idController.text.trim(),
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      photoUrl: _photoUrlController.text.trim().isEmpty
          ? null
          : _photoUrlController.text.trim(),
      isActive: _isActive,
    );
    final notifier = ref.read(teacherListProvider.notifier);
    final error = widget.isEditing
        ? await notifier.updateTeacher(teacher)
        : await notifier.createTeacher(teacher);
    if (!mounted) return;
    setState(() => _saving = false);
    if (error != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    context.go('/admin/teachers/${teacher.id}');
  }
}
