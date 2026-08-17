import 'package:equatable/equatable.dart';

class Habit extends Equatable {
  final String id;
  final String ownerId;
  final String title;
  final String description;
  final String frequency;
  final int target;
  final String unit;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Habit({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.frequency,
    required this.target,
    required this.unit,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    ownerId,
    title,
    description,
    frequency,
    target,
    unit,
    isActive,
    createdAt,
    updatedAt,
  ];
}
