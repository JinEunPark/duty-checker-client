import 'package:duty_checker/check_in/domain/entity/check_in.dart';
import 'package:duty_checker/check_in/domain/repository/check_in_repository.dart';
import 'package:duty_checker/check_in/domain/use_case/create_check_in_use_case.dart';
import 'package:duty_checker/check_in/domain/use_case/get_latest_check_in_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockCheckInRepository extends Mock implements CheckInRepository {}

class MockCreateCheckInUseCase extends Mock implements CreateCheckInUseCase {}

class MockGetLatestCheckInUseCase extends Mock
    implements GetLatestCheckInUseCase {}

// 테스트용 고정 데이터
final testCheckIn = CheckIn(
  id: 1,
  checkedAt: DateTime(2026, 4, 9, 10, 30),
  status: 'CHECKED',
);

const testLatestCheckIn = LatestCheckIn(
  latestCheckedAt: null,
  todayChecked: false,
);

final testLatestCheckInWithData = LatestCheckIn(
  latestCheckedAt: DateTime(2026, 4, 9, 10, 30),
  todayChecked: true,
);
