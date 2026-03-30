import '../models/user_model.dart';

abstract class UserLocalDataSource {
  /// Gets the cached [UserModel] which was saved the last time
  /// the user had an internet connection.
  Future<UserModel> getLastUser();

  Future<void> cacheUser(UserModel userToCache);
}