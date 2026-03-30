import 'package:dio/dio.dart';
import '../../core/error/exceptions.dart';
import '../models/user_model.dart';
import 'user_remote_data_source.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> getUser(String id) async {
    try {
      final response = await client.get(
        'https://jsonplaceholder.typicode.com/users/$id'
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Remote Server Error');
    } catch (e) {
      throw ServerException();
    }
  }

@override
Future<void> updateUser(UserModel user) async {
  try {
    final response = await client.put(
      'https://jsonplaceholder.typicode.com/users/${user.id}',
      data: user.toJson(), // Send the serialized model
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw ServerException();
    }
  } on DioException catch (e) {
    throw ServerException(message: e.message);
  } catch (e) {
    throw ServerException();
  }
}
}