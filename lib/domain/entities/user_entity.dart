import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String name;
  final String email;
  final String? profilePictureUrl;
  final bool isOfflineSynced;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.profilePictureUrl,
    this.isOfflineSynced = false,
  });

  factory UserEntity.placeholder() {
    return const UserEntity(
      id: 0,
      name: 'User Full Name', // Gives the shimmer a realistic width
      email: 'username@example.com',
      profilePictureUrl: null,
      isOfflineSynced: true,
    );
  }

  // Equatable ensures that if the data hasn't changed, 
  // the BLoC won't trigger a UI rebuild.
  @override
  List<Object?> get props => [id, name, email, profilePictureUrl, isOfflineSynced];
}