import 'package:dartz/dartz.dart';
import 'package:zenith_architecture/data/models/user_model.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> getUserProfile(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await remoteDataSource.getUser(id);
        
        // Cache the user locally for future offline use
        await localDataSource.cacheUser(remoteUser);
        
        // Return the Domain Entity
        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localUser = await localDataSource.getLastUser();
        return Right(localUser);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

 @override
Future<Either<Failure, void>> syncUserData(UserEntity user) async {
  if (await networkInfo.isConnected) {
    try {
      final userModel = UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        profilePictureUrl: user.profilePictureUrl,
        isOfflineSynced: true,
      );

      await remoteDataSource.updateUser(userModel);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    }
  } else {
    final userModel = UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      profilePictureUrl: user.profilePictureUrl,
      isOfflineSynced: false,
    );
    await localDataSource.cacheUser(userModel);
    return const Right(null);
  }
}
}