// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeatModelAdapter extends TypeAdapter<SeatModel> {
  @override
  final int typeId = 0;

  @override
  SeatModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeatModel(
      id: fields[0] as int,
      seatName: fields[1] as String,
      isOccupied: fields[2] as bool,
      isSelected: fields[3] as bool,
      side: fields[4] as String,
      classCategory: fields[5] as String,
      price: fields[6] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SeatModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.seatName)
      ..writeByte(2)
      ..write(obj.isOccupied)
      ..writeByte(3)
      ..write(obj.isSelected)
      ..writeByte(4)
      ..write(obj.side)
      ..writeByte(5)
      ..write(obj.classCategory)
      ..writeByte(6)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeatModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
