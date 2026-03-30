import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zenith_architecture/domain/entities/user_entity.dart';
import 'package:zenith_architecture/domain/repositories/user_repository.dart';
import 'package:zenith_architecture/domain/usecases/get_user_profile.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late GetUserProfile usecase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = GetUserProfile(mockUserRepository);
  });

  const tId = '1';
  final tUser = UserEntity.placeholder();

  test('should get user profile from the repository', () async {
    when(() => mockUserRepository.getUserProfile(any()))
        .thenAnswer((_) async => Right(tUser));

    final result = await usecase(const UserParams(id: tId));

    expect(result, Right(tUser));
    
    verify(() => mockUserRepository.getUserProfile(tId)).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });
}