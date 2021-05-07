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

  Map<String, Object> toJson() => {
        '_id': id,
        'title': title,
        'descreption': description,
        'number': number,
        'isImportant': isImportant ? 1 : 0,
        'time': createdTime.toIso8601String()
      };
}
