# CLAUDE.md — 오늘안부 (duty_checker) 프로젝트 가이드

## 프로젝트 개요

"오늘안부" — 당사자(SUBJECT)와 보호자(GUARDIAN)를 연결하여 매일 안부를 확인하는 Flutter 앱.

- **백엔드 API 문서**: `docs/api_spec.json` (OpenAPI 3.1)
- **Base URL**: `https://duty-checker.guegue.dev/api`
- **아키텍처 문서**: `docs/CLEAN_ARCHITECTURE.md`
- **컨벤션 문서**: `docs/CONVENTION.md`
- **남은 작업**: `docs/TODO.md`
- **배포 가이드**: `docs/RELEASE.md` (버전 규칙, 배포 절차, 이력)

## 기술 스택

- Flutter 3.6+ / Dart 3.6+
- 상태 관리: flutter_riverpod + riverpod_generator
- 라우팅: go_router
- 네트워크: dio + retrofit
- 데이터 모델: freezed + json_serializable
- UI: Cupertino 스타일, Pretendard 폰트

## 아키텍처 규칙 (필수 준수)

### Clean Architecture — 3 Layer

```
Presentation → Domain ← Data
```

- **Domain**: 순수 Dart. Flutter/Dio/Riverpod import 금지. Entity는 freezed 불변 객체 (fromJson 금지). Repository는 `abstract interface class`.
- **Data**: Domain의 Repository를 `implements`. DTO에 `toDomain()` 변환. Presentation import 금지.
- **Presentation**: UseCase를 통해서만 데이터 접근. Repository/Data 직접 import 금지.

### 폴더 구조

```
lib/
├── core/
│   ├── network/       # dio_provider, auth_interceptor, token_storage
│   ├── widget/        # 공통 위젯
│   └── *.dart         # shared_preferences_provider, fcm_service
│
├── auth/              # ✅ 완료 (참고용 레퍼런스)
│   ├── domain/
│   │   ├── entity/    # auth_token.dart, user.dart, login_result.dart
│   │   ├── repository/# auth_repository.dart (abstract interface)
│   │   └── use_case/  # login, register, send_code, verify_code, refresh_token, logout + providers
│   ├── data/
│   │   ├── model/     # *_req_model.dart, *_resp_model.dart (freezed + json)
│   │   ├── api/       # auth_api.dart (Retrofit)
│   │   ├── datasource/# auth_remote_datasource.dart
│   │   └── repository/# auth_repository_impl.dart
│   └── presentation/
│       ├── state/     # login_state.dart, sign_up_state.dart (freezed)
│       ├── view_model/# login_view_model.dart, sign_up_view_model.dart (@riverpod class)
│       ├── page/      # 기존 UI 페이지들
│       └── widget/    # 재사용 위젯
│
├── connection/        # 📋 TODO
├── check_in/          # 📋 TODO
├── user/              # 📋 TODO (domain/data 추가 필요)
└── guardian/           # presentation만 존재
```

### Feature 구현 순서 (반드시 이 순서로)

1. `data/model/` — DTO (freezed + json_serializable). api_spec.json의 스키마 참고.
2. `data/api/` — Retrofit 인터페이스
3. `data/datasource/` — RemoteDataSource (API 호출 래핑)
4. `domain/entity/` — 도메인 엔티티 (freezed, fromJson 없음)
5. `domain/repository/` — abstract interface class
6. `data/repository/` — RepositoryImpl (implements interface, DTO → Entity 변환)
7. `domain/use_case/` — 단일 책임 UseCase + Provider 파일
8. `presentation/state/` — UI State (freezed)
9. `presentation/view_model/` — @riverpod class ViewModel
10. 기존 페이지에 ViewModel 연결 (더미 데이터 → API 호출로 교체)

## 코드 생성

모델/API/ViewModel 파일을 추가하거나 수정한 후 반드시 실행:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## 네이밍 컨벤션

| 유형 | 파일명 패턴 | 클래스명 패턴 |
|------|------------|--------------|
| Entity | `{name}.dart` | `{Name}` |
| DTO (요청) | `{name}_req_model.dart` | `{Name}ReqModel` |
| DTO (응답) | `{name}_resp_model.dart` | `{Name}RespModel` |
| Repository Interface | `{name}_repository.dart` | `{Name}Repository` |
| Repository Impl | `{name}_repository_impl.dart` | `{Name}RepositoryImpl` |
| DataSource | `{name}_remote_datasource.dart` | `{Name}RemoteDataSource` |
| API | `{name}_api.dart` | `{Name}Api` |
| UseCase | `{verb}_{name}_use_case.dart` | `{Verb}{Name}UseCase` |
| State | `{name}_state.dart` | `{Name}State` |
| ViewModel | `{name}_view_model.dart` | `{Name}ViewModel` |
| Page | `{name}_page.dart` | `{Name}Page` |

## Provider 패턴

```dart
// Data 레이어 (일반 Provider)
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) { ... });
final authRepositoryProvider = Provider<AuthRepository>((ref) { ... });

// Domain 레이어 UseCase (일반 Provider)
final loginUseCaseProvider = Provider<LoginUseCase>((ref) { ... });

// Presentation 레이어 ViewModel (@riverpod class)
@riverpod
class LoginViewModel extends _$LoginViewModel { ... }
```

## DTO → Entity 변환 패턴

```dart
// DTO 파일 하단에 extension으로 toDomain() 정의
extension LoginRespModelMapper on LoginRespModel {
  LoginResult toDomain() => LoginResult(
    token: AuthToken(accessToken: accessToken ?? '', refreshToken: refreshToken ?? ''),
    user: user!.toDomain(),
  );
}
```

## API 스펙 참조법

`docs/api_spec.json`에서:
- `paths` → 엔드포인트 URL, HTTP 메서드, 요청/응답 스키마 확인
- `components.schemas` → DTO 필드명, 타입, enum 값 확인
- 인증: Bearer JWT (Authorization 헤더 → AuthInterceptor가 자동 첨부)

## 검증 절차

코드 작성 완료 후 반드시:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze
```

생성 파일(*.freezed.dart, *.g.dart)의 warning은 무시 가능.

## 테스트 규칙 (필수)

모든 feature 구현 시 **TDD(Test-Driven Development)** 방식을 따른다. 테스트 작성 시 반드시 `docs/TEST.md`의 규칙을 따른다.

### TDD 절차 (Red → Green → Refactor)

1. **Red**: 구현할 기능에 대한 테스트를 먼저 작성한다. 테스트가 실패하는 것을 확인한다.
2. **Green**: 테스트를 통과하는 최소한의 프로덕션 코드를 작성한다.
3. **Refactor**: 테스트가 통과하는 상태를 유지하면서 코드를 정리한다.

- **테스트 규칙 문서**: `docs/TEST.md` (Mock 패턴, 작성 패턴, 네이밍, 회귀 테스트 규칙)
- **필수 대상**: DTO Model (fromJson/toDomain), UseCase, ViewModel
- **제외 대상**: Page/Widget UI, 생성된 코드
- **Mock 라이브러리**: mocktail (mockito 아님)
- **회귀 테스트**: 테스트 실패로 버그 발견 시, 해당 버그를 재현하는 테스트 케이스를 추가한 뒤 수정

### 검증 절차

코드 작성 완료 후 반드시:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
```

세 단계 모두 통과해야 구현 완료로 간주한다.

## 주의 사항

- Entity에 `fromJson`/`toJson` 넣지 않기 (Data 레이어 관심사)
- ViewModel에서 Repository 직접 접근 금지 (UseCase를 통해서만)
- feature 간 참조는 domain 레이어만 허용
- 기존 페이지 UI는 최대한 유지하고, 더미 데이터/TODO 부분만 API 연결로 교체
- 작업이 완료되면 todo.md 를 업데이트해서 최신 구현된 목록을 완료처리한다
