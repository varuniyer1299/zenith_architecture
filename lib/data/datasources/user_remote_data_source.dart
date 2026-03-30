import '../models/user_model.dart';

abstract class UserRemoteDataSource {
Future<UserModel> getUser(String id);
Future<void> updateUser(UserModel user);
}