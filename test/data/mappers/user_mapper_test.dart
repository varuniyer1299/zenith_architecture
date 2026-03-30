import 'package:flutter_test/flutter_test.dart';
import 'package:zenith_architecture/core/data/mappers/user_mapper.dart';
import 'package:zenith_architecture/data/models/user_model.dart';
import 'package:zenith_architecture/domain/entities/user_entity.dart';

void main() {
  final tUserModel = UserModel(
    id: 1,
    name: 'Test User',
    email: 'test@example.com',
    profilePictureUrl: 'https://image.com/1',
    isOfflineSynced: true,
  );

  final tUserEntity = UserEntity(
    id: 1,
    name: 'Test User',
    email: 'test@example.com',
    profilePictureUrl: 'https://image.com/1',
    isOfflineSynced: true,
  );

  group('UserMapper', () {
    test('toEntity should return a valid Entity from Model', () {
      // Act
      final result = UserMapper.toEntity(tUserModel);

      // Assert
      expect(result, equals(tUserEntity));
    });

    test('fromEntity should return a valid Model from Entity', () {
      // Act
      final result = UserMapper.fromEntity(tUserEntity);

      // Assert
      expect(result, isA<UserModel>());
      expect(result.id, tUserEntity.id);
      expect(result.isOfflineSynced, tUserEntity.isOfflineSynced);
    });
  });
}