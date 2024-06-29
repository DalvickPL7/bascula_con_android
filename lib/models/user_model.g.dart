// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      uid: fields[0] as String,
      avatar: fields[4] as String,
      nombre: fields[1] as String,
      isMasculino: fields[2] as bool,
      fechaNacimiento: fields[3] as DateTime,
      pesoActual: fields[5] as double,
      tallaActual: fields[6] as double,
      imcActual: fields[7] as double,
      historial: (fields[8] as List).cast<HistoryModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.isMasculino)
      ..writeByte(3)
      ..write(obj.fechaNacimiento)
      ..writeByte(4)
      ..write(obj.avatar)
      ..writeByte(5)
      ..write(obj.pesoActual)
      ..writeByte(6)
      ..write(obj.tallaActual)
      ..writeByte(7)
      ..write(obj.imcActual)
      ..writeByte(8)
      ..write(obj.historial);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
