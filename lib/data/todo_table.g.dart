// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoTableAdapter extends TypeAdapter<TodoTable> {
  @override
  final int typeId = 1;

  @override
  TodoTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoTable(
      id: fields[1] as String,
      title: fields[2] as String,
      completed: fields[3] as bool,
      important: fields[4] as dynamic,
      deadline: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, TodoTable obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.completed)
      ..writeByte(4)
      ..write(obj.important)
      ..writeByte(5)
      ..write(obj.deadline);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
