import 'package:zenith_architecture/data/models/user_model.dart';
import 'package:zenith_architecture/domain/entities/user_entity.dart';

class UserMapper {
  //Using a dedicated Mapper ensures the Domain Layer remains completely agnostic of the 
  //persistence framework (Hive) or the API structure (JSON)
  static UserEntity toEntity(UserModel model) {
    return UserEntity(
      id: model.id,
      name: model.name,
      email: model.email,
      profilePictureUrl: model.profilePictureUrl,
      isOfflineSynced: model.isOfflineSynced,
    );
  }

  static UserModel fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      profilePictureUrl: entity.profilePictureUrl,
      isOfflineSynced: entity.isOfflineSynced,
    );
  }
}