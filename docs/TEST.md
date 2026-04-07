# 테스트 작성 규칙

## 테스트 도구

- **flutter_test**: Flutter 기본 테스트 프레임워크
- **mocktail**: Mock 라이브러리 (코드 생성 불필요, mockito 대신 사용)

## 폴더 구조

`test/`는 `lib/`의 구조를 미러링한다.

```
test/
├── {feature}/
│   ├── data/
│   │   └── model/
│   │       └── {name}_model_test.dart
│   ├── domain/
│   │   └── use_case/
│   │       └── {verb}_{name}_use_case_test.dart
│   └── presentation/
│       └── view_model/
│           └── {name}_view_model_test.dart
```

## 테스트 대상

| 대상 | 필수 여부 | Mock 대상 |
|------|----------|----------|
| DTO Model (fromJson, toDomain) | 필수 | 없음 (순수 변환) |
| UseCase | 필수 | Repository |
| ViewModel | 필수 | UseCase (Provider override) |
| Repository | 선택 | DataSource |
| Page / Widget | 제외 | — |
| 생성 코드 (*.g.dart, *.freezed.dart) | 제외 | — |

## Mock 작성 규칙

### mocktail 사용

```dart
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}
```

- Mock 클래스는 **각 테스트 파일 상단**에 선언한다.
- 여러 테스트 파일에서 동일한 Mock을 사용하면 `test/mocks/` 에 공통 Mock 파일을 만든다.

### fallbackValue 등록

`any()`를 named parameter와 함께 사용할 때 필요하면 `setUpAll`에서 등록한다.

```dart
setUpAll(() {
  registerFallbackValue(Uri());
});
```

## 테스트 작성 패턴

### 1. DTO Model 테스트

서버 응답 JSON이 올바르게 파싱되고, Entity 변환이 정확한지 검증한다.

```dart
void main() {
  group('LoginRespModel', () {
    final json = {
      'accessToken': 'access123',
      'refreshToken': 'refresh456',
      'user': {'id': 1, 'phone': '01012345678', 'role': 'GUARDIAN'},
    };

    test('fromJson 파싱', () {
      final model = LoginRespModel.fromJson(json);
      expect(model.accessToken, 'access123');
      expect(model.user?.role, 'GUARDIAN');
    });

    test('toDomain 변환', () {
      final model = LoginRespModel.fromJson(json);
      final result = model.toDomain();
      expect(result.user.role, UserRole.guardian);
      expect(result.token.accessToken, 'access123');
    });

    test('null 필드 처리', () {
      final model = LoginRespModel.fromJson({});
      final result = model.toDomain();
      expect(result.token.accessToken, '');
    });
  });
}
```

**검증 항목:**
- `fromJson`: 모든 필드가 올바르게 매핑되는지
- `toDomain`: Entity 변환이 정확한지, enum 매핑이 맞는지
- null/빈 값: 서버가 필드를 누락했을 때 기본값 처리

### 2. UseCase 테스트

Repository를 Mock하여 UseCase가 올바르게 위임하는지 검증한다.

```dart
void main() {
  late MockAuthRepository mockRepository;
  late LoginUseCase useCase;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LoginUseCase(mockRepository);
  });

  group('LoginUseCase', () {
    test('성공 시 LoginResult를 반환한다', () async {
      final expected = LoginResult(...);
      when(() => mockRepository.login(
        phone: any(named: 'phone'),
        password: any(named: 'password'),
      )).thenAnswer((_) async => expected);

      final result = await useCase(phone: '01012345678', password: 'pw123');
      expect(result, expected);
      verify(() => mockRepository.login(
        phone: '01012345678',
        password: 'pw123',
      )).called(1);
    });

    test('실패 시 예외를 전파한다', () async {
      when(() => mockRepository.login(
        phone: any(named: 'phone'),
        password: any(named: 'password'),
      )).thenThrow(Exception('인증 실패'));

      expect(
        () => useCase(phone: '010', password: 'pw'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
```

**검증 항목:**
- 성공: Repository 메서드가 올바른 인자로 호출되었는지, 반환값이 그대로 전달되는지
- 실패: 예외가 그대로 전파되는지

### 3. ViewModel 테스트 (Riverpod)

ProviderContainer를 사용하여 UseCase를 Mock으로 override한 뒤, 상태 전이를 검증한다.

```dart
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
    test('login 성공 시 user가 설정된다', () async {
      when(() => mockLoginUseCase(
        phone: any(named: 'phone'),
        password: any(named: 'password'),
      )).thenAnswer((_) async => loginResult);

      final notifier = container.read(loginViewModelProvider.notifier);
      await notifier.login(phone: '01012345678', password: 'pw123');

      final state = container.read(loginViewModelProvider);
      expect(state.isLoading, false);
      expect(state.user, isNotNull);
      expect(state.error, isNull);
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
  });
}
```

**검증 항목:**
- 성공: `isLoading` false, 결과 데이터 설정, `error` null
- 실패: `isLoading` false, 결과 데이터 null, `error` 설정
- 호출 전: 초기 상태가 올바른지

## 테스트 네이밍

### 파일명

`lib/auth/data/model/login_resp_model.dart` → `test/auth/data/model/login_resp_model_test.dart`

### group / test 이름

- `group`: 클래스명 또는 메서드명
- `test`: **한국어**로 동작을 서술 (프로젝트 언어 통일)

```dart
group('LoginUseCase', () {
  test('성공 시 LoginResult를 반환한다', () { ... });
  test('Repository 예외를 그대로 전파한다', () { ... });
});
```

## 회귀 테스트 규칙

테스트 실행 중 실패한 케이스를 발견하면:

1. **실패 원인을 분석**한다 (테스트 코드 오류 vs 프로덕션 코드 버그)
2. 프로덕션 코드 버그인 경우:
   - 해당 버그를 재현하는 **최소한의 테스트 케이스를 먼저 추가**한다
   - 추가한 테스트가 실패하는 것을 확인한다 (Red)
   - 프로덕션 코드를 수정한다 (Green)
   - 기존 테스트 + 새 테스트 모두 통과하는 것을 확인한다
3. 테스트 코드 오류인 경우:
   - 테스트 코드를 수정한다
   - 수정 의도가 명확하도록 test 이름에 시나리오를 반영한다

이 과정을 통해 한번 발견된 버그는 다시 발생하지 않도록 보장한다.

## 실행

```bash
# 전체 테스트
flutter test

# 특정 파일
flutter test test/auth/data/model/login_resp_model_test.dart

# 특정 그룹/테스트
flutter test --name "LoginUseCase"
```
