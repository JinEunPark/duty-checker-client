import 'package:duty_checker/auth/domain/entity/auth_token.dart';
import 'package:duty_checker/auth/domain/entity/login_result.dart';
import 'package:duty_checker/auth/domain/entity/user.dart';
import 'package:duty_checker/auth/domain/repository/auth_repository.dart';
import 'package:duty_checker/auth/domain/use_case/login_use_case.dart';
import 'package:duty_checker/auth/domain/use_case/register_use_case.dart';
import 'package:duty_checker/auth/domain/use_case/send_code_use_case.dart';
import 'package:duty_checker/auth/domain/use_case/verify_code_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockSendCodeUseCase extends Mock implements SendCodeUseCase {}

class MockVerifyCodeUseCase extends Mock implements VerifyCodeUseCase {}

// 테스트용 고정 데이터
final testUser = const User(id: 1, phone: '01012345678', role: UserRole.subject);
final testGuardian = const User(id: 2, phone: '01087654321', role: UserRole.guardian);
final testToken = const AuthToken(accessToken: 'access123', refreshToken: 'refresh456');
final testLoginResult = LoginResult(token: testToken, user: testUser);
final testGuardianLoginResult = LoginResult(token: testToken, user: testGuardian);
