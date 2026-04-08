import 'package:dio/dio.dart';
import 'package:duty_checker/auth/domain/use_case/auth_use_case_providers.dart';
import 'package:duty_checker/auth/presentation/view_model/login_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_auth.dart';

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late ProviderContainer container;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    container = ProviderContainer(
      overrides: [
        loginUseCaseProvider.overrideWithValue(mockLoginUseCase),
      ],
    );
  });

  tearDown(() => container.dispose());

  group('LoginViewModel', () {
    test('초기 상태는 isLoading false, user null, error null이다', () {
      final state = container.read(loginViewModelProvider);

      expect(state.isLoading, false);
      expect(state.user, isNull);
      expect(state.error, isNull);
    });

    test('login 성공 시 user가 설정된다', () async {
      when(() => mockLoginUseCase(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => testLoginResult);

      final notifier = container.read(loginViewModelProvider.notifier);
      await notifier.login(phone: '01012345678', password: 'pw123');

      final state = container.read(loginViewModelProvider);
      expect(state.isLoading, false);
      expect(state.user, testUser);
      expect(state.error, isNull);
    });

    test('login 성공 시 guardian role도 올바르게 설정된다', () async {
      when(() => mockLoginUseCase(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => testGuardianLoginResult);

      final notifier = container.read(loginViewModelProvider.notifier);
      await notifier.login(phone: '01087654321', password: 'pw123');

      final state = container.read(loginViewModelProvider);
      expect(state.user?.isGuardian, true);
    });

    test('login 실패 시 error가 설정된다', () async {
      when(() => mockLoginUseCase(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
          )).thenThrow(Exception('인증 실패'));

      final notifier = container.read(loginViewModelProvider.notifier);
      await notifier.login(phone: '010', password: 'wrong');

      final state = container.read(loginViewModelProvider);
      expect(state.isLoading, false);
      expect(state.user, isNull);
      expect(state.error, isNotNull);
    });

    test('DioException 401 시 친절한 에러 메시지가 설정된다', () async {
      when(() => mockLoginUseCase(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
          )).thenThrow(DioException(
        type: DioExceptionType.badResponse,
        requestOptions: RequestOptions(),
        response: Response(
          statusCode: 401,
          requestOptions: RequestOptions(),
          data: {'code': 'INVALID_CREDENTIALS', 'message': '인증 실패'},
        ),
      ));

      final notifier = container.read(loginViewModelProvider.notifier);
      await notifier.login(phone: '01012345678', password: 'wrong');

      final state = container.read(loginViewModelProvider);
      expect(state.error, contains('비밀번호가 일치하지 않아요'));
    });
  });
}
