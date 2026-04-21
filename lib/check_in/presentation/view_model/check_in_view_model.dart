import 'package:duty_checker/check_in/domain/use_case/check_in_use_case_providers.dart';
import 'package:duty_checker/check_in/presentation/state/check_in_state.dart';
import 'package:duty_checker/core/error/app_error.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'check_in_view_model.g.dart';

@riverpod
class CheckInViewModel extends _$CheckInViewModel {
  @override
  CheckInState build() {
    _loadLatestCheckIn();
    return const CheckInState(isLoading: true);
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, error: null);
    await _loadLatestCheckIn();
  }

  Future<void> _loadLatestCheckIn() async {
    try {
      final useCase = ref.read(getLatestCheckInUseCaseProvider);
      final result = await useCase();
      state = CheckInState(
        todayChecked: result.todayChecked,
        latestCheckedAt: result.latestCheckedAt,
      );
    } catch (e) {
      final appError = AppError.from(e);
      state = CheckInState(error: appError.message);
    }
  }

  static const _alreadyCheckedMessage = '오늘은 이미 안부를 전달했어요.';

  Future<void> checkIn() async {
    if (state.isLoading) return;
    if (state.todayChecked) {
      state = state.copyWith(error: _alreadyCheckedMessage);
      return;
    }
    state = state.copyWith(isLoading: true, error: null);
    try {
      final useCase = ref.read(createCheckInUseCaseProvider);
      final result = await useCase();
      state = state.copyWith(
        isLoading: false,
        todayChecked: true,
        latestCheckedAt: result.checkedAt,
      );
    } catch (e) {
      final appError = AppError.from(e);
      if (appError.type == AppErrorType.conflict ||
          appError.statusCode == 400) {
        state = state.copyWith(
          isLoading: false,
          todayChecked: true,
          error: _alreadyCheckedMessage,
        );
      } else {
        state = state.copyWith(isLoading: false, error: appError.message);
      }
    }
  }
}
