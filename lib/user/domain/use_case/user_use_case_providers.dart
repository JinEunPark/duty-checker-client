import 'package:duty_checker/user/data/repository/user_repository_impl.dart';
import 'package:duty_checker/user/domain/use_case/delete_account_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deleteAccountUseCaseProvider = Provider<DeleteAccountUseCase>((ref) {
  return DeleteAccountUseCase(ref.watch(userRepositoryProvider));
});
