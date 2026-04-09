import 'package:duty_checker/auth/data/datasource/auth_remote_datasource.dart';
import 'package:duty_checker/auth/data/model/login_resp_model.dart';
import 'package:duty_checker/auth/data/repository/auth_repository_impl.dart';
import 'package:duty_checker/core/network/token_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockTokenStorage extends Mock implements TokenStorage {}

void main() {
  late MockAuthRemoteDataSource mockDataSource;
  late MockTokenStorage mockTokenStorage;
  late AuthRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockAuthRemoteDataSource();
    mockTokenStorage = MockTokenStorage();
    repository = AuthRepositoryImpl(mockDataSource, mockTokenStorage);
  });

  group('AuthRepositoryImpl.login', () {
    final subjectResp = LoginRespModel(
      accessToken: 'access123',
      refreshToken: 'refresh456',
      user: const UserInfoModel(id: 1, phone: '01012345678', role: 'SUBJECT'),
    );

    final guardianResp = LoginRespModel(
      accessToken: 'access789',
      refreshToken: 'refresh012',
      user: const UserInfoModel(id: 2, phone: '01087654321', role: 'GUARDIAN'),
    );

    test('로그인 성공 시 토큰과 role을 저장한다', () async {
      when(() => mockDataSource.login(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => subjectResp);
      when(() => mockTokenStorage.saveTokens(
            accessToken: any(named: 'accessToken'),
            refreshToken: any(named: 'refreshToken'),
          )).thenAnswer((_) async {});
      when(() => mockTokenStorage.saveRole(any()))
          .thenAnswer((_) async {});

      await repository.login(phone: '01012345678', password: 'pw123');

      verify(() => mockTokenStorage.saveTokens(
            accessToken: 'access123',
            refreshToken: 'refresh456',
          )).called(1);
      verify(() => mockTokenStorage.saveRole('SUBJECT')).called(1);
    });

    test('GUARDIAN 로그인 시 role이 GUARDIAN으로 저장된다', () async {
      when(() => mockDataSource.login(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => guardianResp);
      when(() => mockTokenStorage.saveTokens(
            accessToken: any(named: 'accessToken'),
            refreshToken: any(named: 'refreshToken'),
          )).thenAnswer((_) async {});
      when(() => mockTokenStorage.saveRole(any()))
          .thenAnswer((_) async {});

      final result =
          await repository.login(phone: '01087654321', password: 'pw123');

      expect(result.user.isGuardian, true);
      verify(() => mockTokenStorage.saveRole('GUARDIAN')).called(1);
    });

    test('로그인 성공 시 LoginResult를 올바르게 반환한다', () async {
      when(() => mockDataSource.login(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => subjectResp);
      when(() => mockTokenStorage.saveTokens(
            accessToken: any(named: 'accessToken'),
            refreshToken: any(named: 'refreshToken'),
          )).thenAnswer((_) async {});
      when(() => mockTokenStorage.saveRole(any()))
          .thenAnswer((_) async {});

      final result =
          await repository.login(phone: '01012345678', password: 'pw123');

      expect(result.token.accessToken, 'access123');
      expect(result.token.refreshToken, 'refresh456');
      expect(result.user.phone, '01012345678');
      expect(result.user.isSubject, true);
    });

    test('DataSource 예외를 그대로 전파한다', () async {
      when(() => mockDataSource.login(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
          )).thenThrow(Exception('네트워크 오류'));

      expect(
        () => repository.login(phone: '010', password: 'pw'),
        throwsA(isA<Exception>()),
      );
      verifyNever(() => mockTokenStorage.saveTokens(
            accessToken: any(named: 'accessToken'),
            refreshToken: any(named: 'refreshToken'),
          ));
      verifyNever(() => mockTokenStorage.saveRole(any()));
    });
  });
}
