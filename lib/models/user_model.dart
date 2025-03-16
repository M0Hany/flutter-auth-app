import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:hive_ce/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String name;

  @HiveField(1, defaultValue: '')
  String gender = '';

  @HiveField(2)
  String email;

  @HiveField(3)
  String id;

  @HiveField(4, defaultValue: '')
  String level = '';

  @HiveField(5)
  String password;

  @HiveField(6, defaultValue: null)
  Uint8List? profilePicture;

  User({
    required this.name,
    required this.email,
    required this.id,
    required this.password,
    this.level = '',
    this.gender = '',
    this.profilePicture,
  });
}
