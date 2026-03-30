// ignore_for_file: prefer_initializing_formals, use_super_parameters
import 'package:zenith_architecture/core/constants/hive_types.dart';

import '../../domain/entities/user_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: HiveTypes.userModel)
class UserModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String? profilePictureUrl;

  @HiveField(4)
  final bool isOfflineSynced;
 
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.profilePictureUrl,
     this.isOfflineSynced = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      // We hydrate the model even if the API is missing these
      profilePictureUrl: json['profilePictureUrl'] as String? ?? 
          'https://api.dicebear.com/7.x/avataaars/png?seed=${json['name']}',
      isOfflineSynced: json['isOfflineSynced'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'isOfflineSynced': isOfflineSynced,
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
  return UserModel(
    id: entity.id,
    name: entity.name,
    email: entity.email,
    profilePictureUrl: entity.profilePictureUrl,
    isOfflineSynced: entity.isOfflineSynced,
  );
}

UserEntity toEntity() {
    return UserEntity(
      id: id, 
      name: name,
      email: email,
      profilePictureUrl: profilePictureUrl,
      isOfflineSynced: isOfflineSynced,
    );
  }
}