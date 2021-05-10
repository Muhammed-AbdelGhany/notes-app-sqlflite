import 'package:flutter/cupertino.dart';

class Note {
  final int id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;

  const Note({
    this.id,
    @required this.isImportant,
    @required this.number,
    @required this.title,
    @required this.description,
    @required this.createdTime,
  });

  Note copy(
      {int id,
      bool isImportant,
      int number,
      String title,
      String description,
      DateTime createdTime}) {
    return Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime);
  }

  static Note fromJson(Map<String, Object> json) => Note(
      id: json['_id'] as int,
      isImportant: json['isImportant'] == 1 ? true : false,
      number: json['number'] as int,
      title: json['title'] as String,
      description: json['decription'] as String,
      createdTime: DateTime.parse(json['time'] as String));

  Map<String, Object> toJson() => {
        '_id': id,
        'title': title,
        'decription': description,
        'number': number,
        'isImportant': isImportant ? 1 : 0,
        'time': createdTime.toIso8601String()
      };
}
