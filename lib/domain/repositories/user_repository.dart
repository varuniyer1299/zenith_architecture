import 'package:dartz/dartz.dart';
import 'package:zenith_architecture/core/error/failures.dart';

import '../entities/user_entity.dart';

abstract class UserRepository {
  // Existing function refactored for Clean Architecture
  Future<Either<Failure, UserEntity>> getUserProfile(String id);

  // Existing function for synchronization
  Future<Either<Failure, void>> syncUserData(UserEntity user);
}