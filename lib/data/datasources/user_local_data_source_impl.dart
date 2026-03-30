import 'package:zenith_architecture/core/data/base_local_data_source.dart';
import 'package:zenith_architecture/core/error/exceptions.dart';
import 'package:zenith_architecture/data/datasources/user_local_data_source.dart';
import 'package:zenith_architecture/data/models/user_model.dart';

class UserLocalDataSourceImpl extends BaseLocalDataSource<UserModel> 
    implements UserLocalDataSource {
  
   UserLocalDataSourceImpl({required super.box}) 
      : super(key: 'CACHED_USER');

  @override
  Future<void> cacheUser(UserModel user) => cache(user);

  @override
  Future<UserModel> getLastUser() async {
    final user = getLastCached();
    if (user != null) return user;
    throw CacheException();
  }
}