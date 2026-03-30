import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zenith_architecture/core/network/network_info.dart';
import 'package:zenith_architecture/core/network/network_info_impl.dart';
import 'package:zenith_architecture/data/datasources/user_local_data_source.dart';
import 'package:zenith_architecture/data/datasources/user_local_data_source_impl.dart';
import 'package:zenith_architecture/data/datasources/user_remote_data_source.dart';
import 'package:zenith_architecture/data/datasources/user_remote_data_source_impl.dart';
import 'package:zenith_architecture/data/models/user_model.dart';
import 'package:zenith_architecture/data/repositories/user_repository_impl.dart';
import 'package:zenith_architecture/domain/repositories/user_repository.dart';
import 'package:zenith_architecture/domain/usecases/get_user_profile.dart';
import 'package:zenith_architecture/domain/usecases/sync_user_data.dart';
import 'package:zenith_architecture/presentation/bloc/user_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - User Profile
  // Bloc
  sl.registerFactory(() => UserBloc(getUserProfile: sl(), syncUserData: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetUserProfile(sl()));
  sl.registerLazySingleton(()=>SyncUserData(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: sl()),
  );

  // --- STEP 3: BOX INJECTION ---
  // 1. Open the box first
  final Box<UserModel> userBox = await Hive.openBox<UserModel>('user_box');
  
  // 2. Register the opened box so it can be injected into the LocalDataSource
  sl.registerLazySingleton<Box<UserModel>>(() => userBox);

  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(box: sl()), // sl() finds the Box<UserModel> registered above
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.options = BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );

  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      //For authentication if needed
      // options.headers['Authorization'] = 'Bearer_token';
      return handler.next(options);
    },
  ));
  return dio;
  });
  sl.registerLazySingleton(() => InternetConnection());
}