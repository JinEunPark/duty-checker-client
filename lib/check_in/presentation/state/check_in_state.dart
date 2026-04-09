import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_in_state.freezed.dart';

@freezed
class CheckInState with _$CheckInState {
  const factory CheckInState({
    @Default(false) bool isLoading,
    @Default(false) bool todayChecked,
    DateTime? latestCheckedAt,
    String? error,
  }) = _CheckInState;
}
