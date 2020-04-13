// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Word.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PartOfSpeechAdapter extends TypeAdapter<PartOfSpeech> {
  @override
  final typeId = 0;

  @override
  PartOfSpeech read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PartOfSpeech(
      example: fields[3] as String,
      phonetic: fields[2] as String,
      type: fields[1] as String,
      word: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PartOfSpeech obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.phonetic)
      ..writeByte(3)
      ..write(obj.example);
  }
}

class WordAdapter extends TypeAdapter<Word> {
  @override
  final typeId = 1;

  @override
  Word read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Word(
      id: fields[0] as String,
      audio: fields[6] as String,
      example: (fields[3] as List)?.cast<dynamic>(),
      imageExample: fields[7] as String,
      meaning: (fields[2] as List)?.cast<dynamic>(),
      partOfSpeech: (fields[9] as List)?.cast<PartOfSpeech>(),
      phonetic: fields[4] as String,
      synonym: (fields[8] as List)?.cast<dynamic>(),
      word: fields[1] as String,
      wordType: fields[5] as String,
    )..words = (fields[10] as List)?.cast<Word>();
  }

  @override
  void write(BinaryWriter writer, Word obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.word)
      ..writeByte(2)
      ..write(obj.meaning)
      ..writeByte(3)
      ..write(obj.example)
      ..writeByte(4)
      ..write(obj.phonetic)
      ..writeByte(5)
      ..write(obj.wordType)
      ..writeByte(6)
      ..write(obj.audio)
      ..writeByte(7)
      ..write(obj.imageExample)
      ..writeByte(8)
      ..write(obj.synonym)
      ..writeByte(9)
      ..write(obj.partOfSpeech)
      ..writeByte(10)
      ..write(obj.words);
  }
}

class WordsAdapter extends TypeAdapter<Words> {
  @override
  final typeId = 2;

  @override
  Words read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Words(
      words: (fields[0] as List)?.cast<Word>(),
      next: fields[1] as String,
      previous: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Words obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.words)
      ..writeByte(1)
      ..write(obj.next)
      ..writeByte(2)
      ..write(obj.previous);
  }
}
