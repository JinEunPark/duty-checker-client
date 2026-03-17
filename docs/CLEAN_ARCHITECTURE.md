# Flutter Clean Architecture 설계 문서

## 목차

1. [핵심 원칙](#1-핵심-원칙)
2. [의존성 규칙](#2-의존성-규칙)
3. [레이어 정의](#3-레이어-정의)
4. [폴더 구조](#4-폴더-구조)
5. [레이어별 규칙](#5-레이어별-규칙)
6. [의존성 주입](#6-의존성-주입-riverpod)
7. [코드 예시](#7-코드-예시)
8. [금지 패턴](#8-금지-패턴)
9. [네이밍 컨벤션](#9-네이밍-컨벤션)

---

## 1. 핵심 원칙

### 클린 아키텍처란?

Robert C. Martin(Uncle Bob)이 제안한 아키텍처로, **변경에 강하고 테스트 가능한** 소프트웨어를 만들기 위한 설계 원칙입니다.

```
┌─────────────────────────────────────────┐
│           Presentation Layer            │  ← Flutter 의존
│      (Pages, Widgets, ViewModels)       │
├─────────────────────────────────────────┤
│              Domain Layer               │  ← 순수 Dart
│    (Entities, Use Cases, Interfaces)    │
├─────────────────────────────────────────┤
│               Data Layer                │  ← 외부 의존
│  (Models, DataSources, Repositories)   │
└─────────────────────────────────────────┘
```

핵심은 **도메인 레이어가 어떤 것에도 의존하지 않는다**는 것입니다.
비즈니스 로직은 Flutter, Dio, Riverpod과 무관하게 존재해야 합니다.

---

## 2. 의존성 규칙

### 황금률: 의존성은 반드시 안쪽(Domain)을 향해야 한다

```
Presentation ──→ Domain ←── Data
                   ↑
               의존성의 중심
         (아무것도 의존하지 않음)
```

```
✅ Presentation → Domain     (허용)
✅ Data         → Domain     (허용)
❌ Domain       → Data       (금지)
❌ Domain       → Presentation (금지)
❌ Data         → Presentation (금지)
❌ Presentation → Data       (금지, DI를 통해서만)
```

### 레이어 간 경계 통과 방법

레이어는 직접 참조하지 않고, **추상(인터페이스)** 를 통해서만 통신합니다.

```
Presentation                Domain                   Data
─────────────────────────────────────────────────────────
DutyViewModel               DutyRepository           DutyRepositoryImpl
    │                       (abstract)                       │
    │       UseCase              ↑                           │
    └──→ GetDutiesUseCase ───────┤               implements  │
                                 └───────────────────────────┘
```

---

## 3. 레이어 정의

### Domain Layer (도메인 레이어)

- **책임**: 비즈니스 규칙과 애플리케이션의 핵심 로직
- **의존성**: **없음** (순수 Dart 코드만 허용)
- **구성**: Entity, UseCase, Repository Interface

```
허용 import:
  - dart:core, dart:async 등 Dart 기본 라이브러리
  - freezed_annotation (엔티티 불변 객체용)
  - equatable (값 동등성 비교용)

금지 import:
  - flutter/material.dart
  - package:dio
  - package:retrofit
  - package:riverpod
  - data 레이어의 어떤 파일도
  - presentation 레이어의 어떤 파일도
```

### Data Layer (데이터 레이어)

- **책임**: 외부 데이터 소스(API, DB, Local Storage)와의 통신
- **의존성**: Domain Layer (Repository Interface 구현)
- **구성**: DTO Model, DataSource, Repository Implementation

```
허용 import:
  - domain 레이어 전체
  - package:dio, package:retrofit
  - package:freezed_annotation, package:json_annotation
  - package:shared_preferences
  - core 레이어

금지 import:
  - flutter/material.dart (순수 데이터 레이어)
  - presentation 레이어의 어떤 파일도
```

### Presentation Layer (프레젠테이션 레이어)

- **책임**: UI 렌더링, 사용자 입력 처리, UI 상태 관리
- **의존성**: Domain Layer (UseCase, Entity만 직접 참조)
- **구성**: Page, Widget, ViewModel(Riverpod), State

```
허용 import:
  - domain 레이어 전체
  - flutter/material.dart
  - package:flutter_riverpod
  - package:go_router
  - package:flutter_svg, package:cached_network_image 등 UI 패키지
  - core 레이어

금지 import:
  - data 레이어 (DI를 통해서만 접근)
```

### Core Layer (코어 레이어)

- **책임**: 모든 레이어에서 공유되는 앱 전역 유틸리티
- **의존성**: **없음** (Domain보다도 하위 레이어)
- **구성**: 에러 처리, 네트워크 설정, 공통 위젯, 테마

---

## 4. 폴더 구조

### 전체 구조 (기능 단위 분리)

```
lib/
├── main.dart                        # 앱 진입점, DI 초기화
├── app.dart                         # MaterialApp, 전역 설정
├── router.dart                      # GoRouter 라우팅 설정
│
├── core/                            # 앱 전역 공유 (의존성 없음)
│   ├── error/
│   │   ├── exceptions.dart          # 예외 클래스 정의
│   │   └── failures.dart            # 실패 케이스 (sealed class)
│   ├── network/
│   │   ├── dio_provider.dart        # Dio 인스턴스 설정
│   │   └── api_response.dart        # 공통 API 응답 래퍼
│   ├── storage/
│   │   └── shared_pref_provider.dart
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_theme.dart
│   └── widgets/                     # 재사용 공통 UI 컴포넌트
│       ├── app_loading_widget.dart
│       └── app_error_widget.dart
│
└── features/                        # 도메인 기능 단위
    │
    ├── duty/                        # 당직 관리 기능
    │   │
    │   ├── domain/                  # [순수 Dart] 비즈니스 규칙
    │   │   ├── entity/
    │   │   │   └── duty.dart        # 도메인 엔티티 (불변 객체)
    │   │   ├── repository/
    │   │   │   └── duty_repository.dart   # 추상 인터페이스
    │   │   └── use_case/
    │   │       ├── get_duties_use_case.dart
    │   │       ├── get_duty_detail_use_case.dart
    │   │       ├── create_duty_use_case.dart
    │   │       └── delete_duty_use_case.dart
    │   │
    │   ├── data/                    # 외부 데이터 통신
    │   │   ├── model/
    │   │   │   ├── duty_model.dart          # DTO (API 응답 매핑)
    │   │   │   ├── duty_model.freezed.dart  # 생성 파일
    │   │   │   └── duty_model.g.dart        # 생성 파일
    │   │   ├── datasource/
    │   │   │   ├── duty_remote_datasource.dart
    │   │   │   └── duty_local_datasource.dart
    │   │   ├── api/
    │   │   │   ├── duty_api.dart            # Retrofit 인터페이스
    │   │   │   └── duty_api.g.dart          # 생성 파일
    │   │   └── repository/
    │   │       └── duty_repository_impl.dart # 인터페이스 구현체
    │   │
    │   └── presentation/            # UI 및 상태 관리
    │       ├── state/
    │       │   ├── duty_state.dart          # UI 상태 정의 (freezed)
    │       │   └── duty_state.freezed.dart  # 생성 파일
    │       ├── view_model/
    │       │   ├── duty_view_model.dart     # Riverpod Notifier
    │       │   └── duty_view_model.g.dart   # 생성 파일
    │       ├── page/
    │       │   ├── duty_list_page.dart
    │       │   └── duty_detail_page.dart
    │       └── widget/
    │           ├── duty_card_widget.dart
    │           └── duty_filter_widget.dart
    │
    ├── schedule/                    # 근무 일정 기능 (동일 구조)
    │   ├── domain/
    │   ├── data/
    │   └── presentation/
    │
    └── auth/                        # 인증 기능 (동일 구조)
        ├── domain/
        ├── data/
        └── presentation/
```

### 기능 간 의존성 규칙

```
features/
  auth/         → (다른 feature에 의존 금지)
  duty/         → auth/domain만 허용 (예: 현재 유저 정보)
  schedule/     → duty/domain만 허용 (예: 당직 엔티티 참조)

규칙: feature 간 참조는 domain 레이어만 허용
     presentation, data 레이어 간 직접 참조 금지
```

---

## 5. 레이어별 규칙

### Domain Layer 규칙

#### Entity
- Freezed로 **불변(Immutable)** 객체로 정의
- `fromJson` / `toJson` **금지** (JSON은 Data 레이어 관심사)
- 비즈니스 유효성 검증 메서드 포함 가능

```
✅ duty.copyWith(status: DutyStatus.completed)  - 불변 업데이트
✅ duty.isExpired()                             - 비즈니스 규칙
❌ DutyModel.fromJson(json)                     - Data 레이어 역할
```

#### Repository Interface
- 추상 클래스로 정의 (구현체는 Data 레이어에)
- 반환 타입은 반드시 **Domain Entity** 사용
- `Future<T>` 또는 `Stream<T>` 반환

```
✅ Future<List<Duty>> getDuties()               - 엔티티 반환
❌ Future<List<DutyModel>> getDuties()           - DTO 반환 금지
```

#### Use Case
- 단일 책임 원칙: **하나의 UseCase = 하나의 기능**
- `call()` 메서드로 실행 (invoke operator 패턴)
- 비즈니스 규칙 검증은 UseCase에서 처리

```
✅ GetDutiesUseCase  - 당직 목록 조회
✅ CreateDutyUseCase - 당직 생성
❌ DutyUseCase       - 여러 기능을 하나에 담는 것 금지
```

### Data Layer 규칙

#### DTO Model
- API 응답 구조를 그대로 반영 (`snake_case` → `camelCase`)
- `fromJson` / `toJson` 포함
- Domain Entity로 변환하는 `toDomain()` 메서드 포함

```
✅ DutyModel.fromJson(json)  - JSON 역직렬화
✅ dutyModel.toDomain()      - 엔티티 변환
❌ DutyModel 을 Presentation에서 직접 사용  - 금지
```

#### Repository Implementation
- Domain의 Repository Interface를 `implements`
- DataSource를 통해 데이터 가져오기
- DTO → Entity 변환 책임

```
✅ class DutyRepositoryImpl implements DutyRepository
❌ class DutyRepositoryImpl extends DutyRepository    - abstract class이므로 금지
```

### Presentation Layer 규칙

#### ViewModel (Riverpod Notifier)
- UseCase를 주입받아 사용 (Repository 직접 접근 금지)
- UI 상태(State)만 관리
- 비즈니스 로직 포함 금지

```
✅ ref.watch(getDutiesUseCaseProvider)       - UseCase 사용
❌ ref.watch(dutyRepositoryProvider)         - Repository 직접 접근 금지
❌ if (duty.deadline.isBefore(now)) { ... }  - 비즈니스 로직 금지
```

#### Page / Widget
- ViewModel의 State를 구독하여 렌더링
- 사용자 이벤트를 ViewModel 메서드로 위임
- `ConsumerWidget` 또는 `Consumer` 사용

---

## 6. 의존성 주입 (Riverpod)

### DI 바인딩 순서

```dart
// main.dart - 최하위 레이어부터 상위 레이어 순으로 바인딩

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. 인프라 초기화
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        // 2. 외부 의존성 주입
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const App(),
    ),
  );
}
```

### Provider 계층 설계

```
[core]
sharedPreferencesProvider     # SharedPreferences 인스턴스
dioProvider                   # Dio 인스턴스

[data]
dutyApiProvider               # Retrofit API 클라이언트
dutyRemoteDataSourceProvider  # 원격 데이터 소스
dutyLocalDataSourceProvider   # 로컬 데이터 소스
dutyRepositoryProvider        # Repository 구현체 (Domain Interface 타입)

[domain]
getDutiesUseCaseProvider      # UseCase (Repository 주입)
createDutyUseCaseProvider

[presentation]
dutyViewModelProvider         # ViewModel (UseCase 주입)
```

### Provider 타입 선택 기준

| 상황 | Provider 타입 |
|------|--------------|
| 변경 없는 단순 객체 (Dio, Repository) | `@riverpod` function |
| UI 상태 관리 | `@riverpod` class (AsyncNotifier / Notifier) |
| 앱 생명주기 동안 유지 | `@Riverpod(keepAlive: true)` |
| 비동기 데이터 (API 호출) | `AsyncNotifier` 또는 `FutureProvider` |

---

## 7. 코드 예시

### Domain Entity

```dart
// features/duty/domain/entity/duty.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'duty.freezed.dart';

enum DutyStatus { scheduled, inProgress, completed, cancelled }

@freezed
class Duty with _$Duty {
  const Duty._();

  const factory Duty({
    required int id,
    required String title,
    required String assignee,
    required DateTime date,
    required DutyStatus status,
    String? description,
  }) = _Duty;

  // 비즈니스 규칙은 엔티티에 포함 가능
  bool get isExpired => date.isBefore(DateTime.now());
  bool get isEditable => status == DutyStatus.scheduled;
}
```

### Repository Interface

```dart
// features/duty/domain/repository/duty_repository.dart
import '../entity/duty.dart';

abstract interface class DutyRepository {
  Future<List<Duty>> getDuties();
  Future<Duty> getDutyById(int id);
  Future<Duty> createDuty({
    required String title,
    required String assignee,
    required DateTime date,
    String? description,
  });
  Future<void> deleteDuty(int id);
}
```

### Use Case

```dart
// features/duty/domain/use_case/get_duties_use_case.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../entity/duty.dart';
import '../repository/duty_repository.dart';
import '../../data/repository/duty_repository_provider.dart';

part 'get_duties_use_case.g.dart';

class GetDutiesUseCase {
  final DutyRepository _repository;
  GetDutiesUseCase(this._repository);

  Future<List<Duty>> call() async {
    return _repository.getDuties();
  }
}

@riverpod
GetDutiesUseCase getDutiesUseCase(GetDutiesUseCaseRef ref) {
  return GetDutiesUseCase(ref.watch(dutyRepositoryProvider));
}
```

### DTO Model

```dart
// features/duty/data/model/duty_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entity/duty.dart';

part 'duty_model.freezed.dart';
part 'duty_model.g.dart';

@freezed
class DutyModel with _$DutyModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DutyModel({
    required int id,
    required String title,
    required String assignee,
    required String date,
    required String status,
    String? description,
  }) = _DutyModel;

  factory DutyModel.fromJson(Map<String, dynamic> json) =>
      _$DutyModelFromJson(json);
}

// DTO → Entity 변환 extension
extension DutyModelMapper on DutyModel {
  Duty toDomain() => Duty(
        id: id,
        title: title,
        assignee: assignee,
        date: DateTime.parse(date),
        status: DutyStatus.values.byName(status),
        description: description,
      );
}
```

### Repository Implementation

```dart
// features/duty/data/repository/duty_repository_impl.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entity/duty.dart';
import '../../domain/repository/duty_repository.dart';
import '../datasource/duty_remote_datasource.dart';
import '../model/duty_model.dart';

part 'duty_repository_impl.g.dart';

class DutyRepositoryImpl implements DutyRepository {
  final DutyRemoteDataSource _remoteDataSource;

  DutyRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Duty>> getDuties() async {
    final models = await _remoteDataSource.getDuties();
    return models.map((m) => m.toDomain()).toList();
  }

  @override
  Future<Duty> getDutyById(int id) async {
    final model = await _remoteDataSource.getDutyById(id);
    return model.toDomain();
  }

  @override
  Future<Duty> createDuty({
    required String title,
    required String assignee,
    required DateTime date,
    String? description,
  }) async {
    final model = await _remoteDataSource.createDuty(
      title: title,
      assignee: assignee,
      date: date.toIso8601String(),
      description: description,
    );
    return model.toDomain();
  }

  @override
  Future<void> deleteDuty(int id) => _remoteDataSource.deleteDuty(id);
}

// DutyRepository 타입(인터페이스)으로 제공 → Presentation은 Impl을 모름
@riverpod
DutyRepository dutyRepository(DutyRepositoryRef ref) {
  return DutyRepositoryImpl(ref.watch(dutyRemoteDataSourceProvider));
}
```

### ViewModel

```dart
// features/duty/presentation/view_model/duty_view_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entity/duty.dart';
import '../../domain/use_case/get_duties_use_case.dart';
import '../../domain/use_case/delete_duty_use_case.dart';
import '../state/duty_state.dart';

part 'duty_view_model.g.dart';

@riverpod
class DutyViewModel extends _$DutyViewModel {
  @override
  DutyState build() => const DutyState();

  Future<void> fetchDuties() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final useCase = ref.read(getDutiesUseCaseProvider);
      final duties = await useCase();
      state = state.copyWith(duties: duties, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> deleteDuty(int id) async {
    final useCase = ref.read(deleteDutyUseCaseProvider);
    await useCase(id);
    await fetchDuties();
  }
}
```

### Page

```dart
// features/duty/presentation/page/duty_list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_model/duty_view_model.dart';
import '../widget/duty_card_widget.dart';

class DutyListPage extends ConsumerStatefulWidget {
  const DutyListPage({super.key});

  @override
  ConsumerState<DutyListPage> createState() => _DutyListPageState();
}

class _DutyListPageState extends ConsumerState<DutyListPage> {
  @override
  void initState() {
    super.initState();
    // 화면 진입 시 데이터 로드
    Future.microtask(() => ref.read(dutyViewModelProvider.notifier).fetchDuties());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dutyViewModelProvider);

    if (state.isLoading) return const Center(child: CircularProgressIndicator());
    if (state.error != null) return Center(child: Text(state.error!));

    return ListView.builder(
      itemCount: state.duties.length,
      itemBuilder: (context, index) => DutyCardWidget(duty: state.duties[index]),
    );
  }
}
```

---

## 8. 금지 패턴

### ❌ Domain에서 외부 패키지 import

```dart
// ❌ 잘못된 예
import 'package:dio/dio.dart';                    // HTTP 클라이언트
import 'package:flutter/material.dart';            // Flutter UI
import 'package:riverpod/riverpod.dart';           // 상태 관리
import '../../data/model/duty_model.dart';         // Data 레이어
```

### ❌ Presentation에서 Data 레이어 직접 접근

```dart
// ❌ 잘못된 예 - ViewModel에서 Repository Impl 직접 참조
class DutyViewModel extends _$DutyViewModel {
  Future<void> fetch() async {
    // 구현체를 직접 참조하면 Data 레이어에 의존하게 됨
    final repo = DutyRepositoryImpl(DutyRemoteDataSource(DutyApi(dio)));
    final duties = await repo.getDuties();
  }
}
```

```dart
// ✅ 올바른 예 - UseCase를 통해 Domain 레이어만 참조
class DutyViewModel extends _$DutyViewModel {
  Future<void> fetch() async {
    final useCase = ref.read(getDutiesUseCaseProvider);
    final duties = await useCase();
  }
}
```

### ❌ DTO를 UI에서 직접 사용

```dart
// ❌ 잘못된 예 - Page에서 DutyModel(DTO) 직접 사용
class DutyCardWidget extends StatelessWidget {
  final DutyModel duty; // DTO를 Widget에 전달
}
```

```dart
// ✅ 올바른 예 - Domain Entity 사용
class DutyCardWidget extends StatelessWidget {
  final Duty duty; // 도메인 엔티티 사용
}
```

### ❌ ViewModel에서 비즈니스 로직 처리

```dart
// ❌ 잘못된 예 - 비즈니스 규칙이 ViewModel에 있음
Future<void> completeDuty(Duty duty) async {
  if (duty.date.isAfter(DateTime.now())) {  // 비즈니스 규칙!
    throw Exception("미래 당직은 완료할 수 없습니다.");
  }
  await repository.updateStatus(duty.id, 'completed');
}
```

```dart
// ✅ 올바른 예 - 비즈니스 규칙은 UseCase 또는 Entity에
// Entity에서:
bool get isCompletable => !date.isAfter(DateTime.now());

// UseCase에서:
Future<void> call(int dutyId) async {
  final duty = await _repository.getDutyById(dutyId);
  if (!duty.isCompletable) throw CannotCompleteException();
  await _repository.updateStatus(dutyId, DutyStatus.completed);
}
```

### ❌ 기능 간 레이어 경계 위반

```dart
// ❌ 잘못된 예 - schedule 기능의 Presentation이 duty의 Data 직접 참조
import '../../duty/data/repository/duty_repository_impl.dart';
```

```dart
// ✅ 올바른 예 - domain 레이어를 통해서만 참조
import '../../duty/domain/entity/duty.dart';
import '../../duty/domain/use_case/get_duties_use_case.dart';
```

---

## 9. 네이밍 컨벤션

### 파일명

| 유형 | 패턴 | 예시 |
|------|------|------|
| Entity | `{name}.dart` | `duty.dart` |
| DTO Model | `{name}_model.dart` | `duty_model.dart` |
| Repository Interface | `{name}_repository.dart` | `duty_repository.dart` |
| Repository Impl | `{name}_repository_impl.dart` | `duty_repository_impl.dart` |
| DataSource | `{name}_{remote/local}_datasource.dart` | `duty_remote_datasource.dart` |
| API | `{name}_api.dart` | `duty_api.dart` |
| UseCase | `{verb}_{name}_use_case.dart` | `get_duties_use_case.dart` |
| State | `{name}_state.dart` | `duty_state.dart` |
| ViewModel | `{name}_view_model.dart` | `duty_view_model.dart` |
| Page | `{name}_page.dart` | `duty_list_page.dart` |
| Widget | `{name}_widget.dart` | `duty_card_widget.dart` |

### 클래스명

| 유형 | 패턴 | 예시 |
|------|------|------|
| Entity | `PascalCase` | `Duty` |
| DTO Model | `{Name}Model` | `DutyModel` |
| Repository Interface | `{Name}Repository` | `DutyRepository` |
| Repository Impl | `{Name}RepositoryImpl` | `DutyRepositoryImpl` |
| UseCase | `{Verb}{Name}UseCase` | `GetDutiesUseCase` |
| ViewModel | `{Name}ViewModel` | `DutyViewModel` |
| State | `{Name}State` | `DutyState` |
| Page | `{Name}Page` | `DutyListPage` |
| Widget | `{Name}Widget` | `DutyCardWidget` |

### UseCase 동사 규칙

| 동작 | 동사 | 예시 |
|------|------|------|
| 조회 (목록) | `Get` | `GetDutiesUseCase` |
| 조회 (단건) | `Get` | `GetDutyDetailUseCase` |
| 생성 | `Create` | `CreateDutyUseCase` |
| 수정 | `Update` | `UpdateDutyUseCase` |
| 삭제 | `Delete` | `DeleteDutyUseCase` |
| 상태 변경 | `{Action}` | `CompleteDutyUseCase` |

---

## 요약: 레이어별 체크리스트

### Domain Layer 체크리스트
- [ ] Flutter 패키지 import 없음
- [ ] Dio, Retrofit import 없음
- [ ] Riverpod import 없음 (UseCase Provider 제외)
- [ ] Data 레이어 파일 import 없음
- [ ] Repository는 `abstract interface class`로 정의
- [ ] Entity는 불변(Freezed) 객체
- [ ] UseCase는 단일 책임

### Data Layer 체크리스트
- [ ] Domain Repository Interface를 `implements`
- [ ] DTO에 `toDomain()` 변환 메서드 포함
- [ ] Presentation 레이어 import 없음
- [ ] Flutter Widget import 없음
- [ ] Repository Provider는 인터페이스 타입으로 반환

### Presentation Layer 체크리스트
- [ ] Data 레이어 직접 import 없음
- [ ] UseCase를 통해서만 데이터 접근
- [ ] Domain Entity를 UI에 전달
- [ ] 비즈니스 로직은 ViewModel에 없음
- [ ] Widget은 State만 표시, 로직은 ViewModel에 위임
