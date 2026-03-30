import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetUserProfile implements UseCase<UserEntity, UserParams> {
  final UserRepository repository;

  GetUserProfile(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(UserParams params) async {
    return await repository.getUserProfile(params.id);
  }
}

class UserParams extends Equatable {
  final String id;

  const UserParams({required this.id});

  @override
  List<Object?> get props => [id];
}