import 'package:duty_checker/connection/domain/entity/connection.dart';
import 'package:duty_checker/connection/domain/repository/connection_repository.dart';
import 'package:duty_checker/connection/domain/use_case/accept_connection_use_case.dart';
import 'package:duty_checker/connection/domain/use_case/add_connection_use_case.dart';
import 'package:duty_checker/connection/domain/use_case/delete_connection_use_case.dart';
import 'package:duty_checker/connection/domain/use_case/get_connections_use_case.dart';
import 'package:duty_checker/connection/domain/use_case/reject_connection_use_case.dart';
import 'package:duty_checker/connection/domain/use_case/update_connection_name_use_case.dart';
import 'package:duty_checker/auth/domain/entity/user.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectionRepository extends Mock implements ConnectionRepository {}

class MockGetConnectionsUseCase extends Mock implements GetConnectionsUseCase {}

class MockAddConnectionUseCase extends Mock implements AddConnectionUseCase {}

class MockUpdateConnectionNameUseCase extends Mock
    implements UpdateConnectionNameUseCase {}

class MockAcceptConnectionUseCase extends Mock
    implements AcceptConnectionUseCase {}

class MockRejectConnectionUseCase extends Mock
    implements RejectConnectionUseCase {}

class MockDeleteConnectionUseCase extends Mock
    implements DeleteConnectionUseCase {}

// 테스트용 고정 데이터
const testConnection = Connection(
  id: 1,
  phone: '01012345678',
  name: '엄마',
  status: ConnectionStatus.connected,
  latestCheckedAt: null,
  isTodayChecked: false,
);

const testPendingConnection = Connection(
  id: 2,
  phone: '01087654321',
  name: '아빠',
  status: ConnectionStatus.pending,
  latestCheckedAt: null,
  isTodayChecked: false,
);

final testConnectionList = ConnectionList(
  role: UserRole.subject,
  connections: [testConnection, testPendingConnection],
);
