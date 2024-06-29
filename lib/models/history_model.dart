import 'package:hive/hive.dart';

part 'history_model.g.dart';

@HiveType(typeId: 1)
class HistoryModel {
  @HiveField(0)
  final double peso;

  @HiveField(1)
  final double talla;

  @HiveField(2)
  final double imc;

  @HiveField(3)
  final DateTime fecha;

  HistoryModel({
    required this.peso,
    required this.talla,
    required this.imc,
    required this.fecha,
  });
}
