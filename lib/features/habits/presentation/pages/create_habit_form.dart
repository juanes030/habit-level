import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_level/features/habits/presentation/bloc/habit/habit_bloc.dart';

import '../../domain/entities/habit.dart';

class CreateHabitForm extends StatefulWidget {
  final String ownerId;

  const CreateHabitForm({super.key, required this.ownerId});

  @override
  State<CreateHabitForm> createState() => _CreateHabitFormState();
}

class _CreateHabitFormState extends State<CreateHabitForm> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetController = TextEditingController();

  String _frequency = 'daily';
  String _unit = 'minutes';

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final habit = Habit(
      id: '',
      ownerId: widget.ownerId,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      frequency: _frequency,
      target: int.parse(_targetController.text),
      unit: _unit,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    context.read<HabitBloc>().add(HabitCreateRequested(habit));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Nombre'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Ingresa un nombre';
              }

              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Descripción'),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _frequency,
            decoration: const InputDecoration(labelText: 'Frecuencia'),
            items: const [
              DropdownMenuItem(value: 'daily', child: Text('Diario')),
              DropdownMenuItem(value: 'weekly', child: Text('Semanal')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _frequency = value;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _targetController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Objetivo'),
            validator: (value) {
              final target = int.tryParse(value ?? '');

              if (target == null || target <= 0) {
                return 'Ingresa un objetivo válido';
              }

              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _unit,
            decoration: const InputDecoration(labelText: 'Unidad'),
            items: const [
              DropdownMenuItem(value: 'minutes', child: Text('Minutos')),
              DropdownMenuItem(value: 'kilometers', child: Text('Kilómetros')),
              DropdownMenuItem(value: 'glasses', child: Text('Vasos')),
              DropdownMenuItem(
                value: 'repetitions',
                child: Text('Repeticiones'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _unit = value;
                });
              }
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submit,
              child: const Text('Crear hábito'),
            ),
          ),
        ],
      ),
    );
  }
}
