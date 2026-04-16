import 'package:duty_checker/user/domain/repository/user_repository.dart';
import 'package:duty_checker/user/domain/use_case/delete_account_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockDeleteAccountUseCase extends Mock implements DeleteAccountUseCase {}
