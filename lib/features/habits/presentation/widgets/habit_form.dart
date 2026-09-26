import 'package:flutter/material.dart';
import 'package:habit_level/app/theme/app_spacing.dart';

import '../../domain/entities/habit.dart';

@immutable
class HabitFormData {
  final String title;
  final String description;
  final String frequency;
  final int target;
  final String unit;

  const HabitFormData({
    required this.title,
    required this.description,
    required this.frequency,
    required this.target,
    required this.unit,
  });
}

class HabitForm extends StatefulWidget {
  final Habit? initialHabit;
  final ValueChanged<HabitFormData> onSubmit;
  final String submitLabel;
  final bool isSubmitting;

  const HabitForm({
    super.key,
    required this.onSubmit,
    this.initialHabit,
    this.submitLabel = 'Crear hábito',
    this.isSubmitting = false,
  });

  @override
  State<HabitForm> createState() => _HabitFormState();
}

class _HabitFormState extends State<HabitForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _targetController;

  late String _frequency;
  late String _unit;

  @override
  void initState() {
    super.initState();
    final habit = widget.initialHabit;
    _titleController = TextEditingController(text: habit?.title ?? '');
    _descriptionController = TextEditingController(
      text: habit?.description ?? '',
    );
    _targetController = TextEditingController(
      text: habit == null ? '' : habit.target.toString(),
    );
    _frequency = habit?.frequency ?? 'daily';
    _unit = habit?.unit ?? 'minutes';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate() || widget.isSubmitting) {
      return;
    }

    widget.onSubmit(
      HabitFormData(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        frequency: _frequency,
        target: int.parse(_targetController.text),
        unit: _unit,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INFORMACIÓN',
            style: textTheme.labelMedium?.copyWith(color: colorScheme.primary),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextFormField(
            controller: _titleController,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'Nombre del hábito',
              hintText: 'Por ejemplo, leer antes de dormir',
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Ingresa un nombre';
              }

              return null;
            },
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: _descriptionController,
            textCapitalization: TextCapitalization.sentences,
            minLines: 2,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Descripción (opcional)',
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'OBJETIVO',
            style: textTheme.labelMedium?.copyWith(color: colorScheme.primary),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: TextFormField(
                  controller: _targetController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Cantidad'),
                  validator: (value) {
                    final target = int.tryParse(value ?? '');

                    if (target == null || target <= 0) {
                      return 'Ingresa un objetivo válido';
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                flex: 6,
                child: DropdownButtonFormField<String>(
                  initialValue: _unit,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Unidad'),
                  items: const [
                    DropdownMenuItem(value: 'minutes', child: Text('Minutos')),
                    DropdownMenuItem(
                      value: 'kilometers',
                      child: Text('Kilómetros'),
                    ),
                    DropdownMenuItem(value: 'glasses', child: Text('Vasos')),
                    DropdownMenuItem(
                      value: 'repetitions',
                      child: Text('Repeticiones'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _unit = value);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'FRECUENCIA',
            style: textTheme.labelMedium?.copyWith(color: colorScheme.primary),
          ),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<String>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(
                  value: 'daily',
                  icon: Icon(Icons.today_outlined),
                  label: Text('Diario'),
                ),
                ButtonSegment(
                  value: 'weekly',
                  icon: Icon(Icons.date_range_outlined),
                  label: Text('Semanal'),
                ),
              ],
              selected: {_frequency},
              onSelectionChanged: (selection) {
                setState(() => _frequency = selection.first);
              },
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: widget.isSubmitting ? null : _submit,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.isSubmitting)
                    SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colorScheme.onPrimary,
                      ),
                    )
                  else
                    const Icon(Icons.add),
                  const SizedBox(width: AppSpacing.sm),
                  Text(widget.isSubmitting ? 'Guardando' : widget.submitLabel),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
