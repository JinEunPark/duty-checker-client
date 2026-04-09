import 'package:duty_checker/check_in/data/repository/check_in_repository_impl.dart';
import 'package:duty_checker/check_in/domain/use_case/create_check_in_use_case.dart';
import 'package:duty_checker/check_in/domain/use_case/get_latest_check_in_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createCheckInUseCaseProvider = Provider<CreateCheckInUseCase>((ref) {
  return CreateCheckInUseCase(ref.watch(checkInRepositoryProvider));
});

final getLatestCheckInUseCaseProvider =
    Provider<GetLatestCheckInUseCase>((ref) {
  return GetLatestCheckInUseCase(ref.watch(checkInRepositoryProvider));
});
