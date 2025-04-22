// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AvailabilityStatusAdapter extends TypeAdapter<AvailabilityStatus> {
  @override
  final int typeId = 3;

  @override
  AvailabilityStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AvailabilityStatus.inStock;
      case 1:
        return AvailabilityStatus.lowStock;
      case 2:
        return AvailabilityStatus.outOfStock;
      default:
        return AvailabilityStatus.inStock;
    }
  }

  @override
  void write(BinaryWriter writer, AvailabilityStatus obj) {
    switch (obj) {
      case AvailabilityStatus.inStock:
        writer.writeByte(0);
        break;
      case AvailabilityStatus.lowStock:
        writer.writeByte(1);
        break;
      case AvailabilityStatus.outOfStock:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AvailabilityStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
