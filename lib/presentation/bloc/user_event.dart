import 'package:equatable/equatable.dart';
import 'package:zenith_architecture/domain/entities/user_entity.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class GetUserProfileEvent extends UserEvent {
  final String id;
  const GetUserProfileEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class RefreshUserProfileEvent extends UserEvent {
  final String id;
  const RefreshUserProfileEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class SyncUserDataEvent extends UserEvent {
  final UserEntity user;
  const SyncUserDataEvent(this.user);

  @override
  List<Object?> get props => [user];
}