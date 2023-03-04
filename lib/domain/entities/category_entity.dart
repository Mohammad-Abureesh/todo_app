import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/data_base_config.dart';

import 'base_entity.dart';

class CategoryEntity implements BaseEntity {
  final int _id;
  final String _name;
  final int _icon;
  final int _color;
  final DateTime _creationDate;

  CategoryEntity._(
      this._id, this._name, this._icon, this._color, this._creationDate);

  CategoryEntity.create(
      {required String name, required IconData icon, Color? color})
      : _id = 0,
        _name = name,
        _icon = icon.codePoint,
        _color = color?.value ?? Colors.grey.value,
        _creationDate = DateTime.now();

  @override
  int get id => _id;

  @override
  String get table => DbConfig.categoryT;
  String get name => _name;

  Color get color => Color(_color);

  IconData get icon => IconData(_icon, fontFamily: 'MaterialIcons');

  DateTime get creationDate => _creationDate;

  @override
  Map<String, dynamic> get toMap => {
        'name': _name,
        'icon': _icon,
        'color': _color,
        'createdAt': _creationDate.toIso8601String()
      };

  factory CategoryEntity.fromMap(Map<String, dynamic> map) {
    return CategoryEntity._(map['id'], map['name'], map['icon'], map['color'],
        DateTime.parse(map['createdAt']));
  }
}
