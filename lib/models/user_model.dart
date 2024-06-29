import 'package:flutter_application/models/history_model.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String uid;

  @HiveField(1)
  final String nombre;

  @HiveField(2)
  final bool isMasculino;

  @HiveField(3)
  final DateTime fechaNacimiento;

  @HiveField(4)
  final String avatar;

  @HiveField(5)
  final double pesoActual; //en cm

  @HiveField(6)
  final double tallaActual; //en kg

  @HiveField(7)
  final double imcActual;

  @HiveField(8)
  final List<HistoryModel> historial;

  UserModel({
    required this.uid,
    required this.avatar,
    required this.nombre,
    required this.isMasculino,
    required this.fechaNacimiento,
    required this.pesoActual,
    required this.tallaActual,
    required this.imcActual,
    required this.historial,
  });
}
