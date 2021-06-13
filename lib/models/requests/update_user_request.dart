import 'dart:io';

import 'package:moleculis/models/enums/gender.dart';

class UpdateUserRequest {
  final String? displayName;
  final String? fullName;
  final Gender? gender;
  final String? username;
  final String? email;
  final File? newAvatar;

  UpdateUserRequest({
    this.displayName,
    this.fullName,
    this.gender,
    this.username,
    this.email,
    this.newAvatar,
  });

  Map<String, dynamic> toMap() {
    return {
      'displayname': this.displayName,
      'fullname': this.fullName,
      'gender': this.gender?.name,
      'username': this.username,
      'email': this.email,
    };
  }
}
