# duty_checker

당직 및 근무 일정을 관리하는 Flutter 애플리케이션입니다.

## 기술 스택

| 분류 | 기술 |
|------|------|
| 상태 관리 | [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) + [riverpod_generator](https://pub.dev/packages/riverpod_generator) |
| 네비게이션 | [go_router](https://pub.dev/packages/go_router) |
| 네트워크 | [dio](https://pub.dev/packages/dio) + [retrofit](https://pub.dev/packages/retrofit) |
| 데이터 모델 | [freezed](https://pub.dev/packages/freezed) + [json_serializable](https://pub.dev/packages/json_serializable) |
| 로컬 저장소 | [shared_preferences](https://pub.dev/packages/shared_preferences) |
| 이미지 | [cached_network_image](https://pub.dev/packages/cached_network_image) + [flutter_svg](https://pub.dev/packages/flutter_svg) |
| 코드 품질 | [custom_lint](https://pub.dev/packages/custom_lint) + [riverpod_lint](https://pub.dev/packages/riverpod_lint) |

## 아키텍처

Clean Architecture 기반의 레이어드 구조를 따릅니다.

```
lib/
├── main.dart              # 앱 진입점
├── router.dart            # GoRouter 라우팅 설정
├── theme.dart             # 앱 테마 및 색상 정의
├── model/                 # 데이터 모델 (freezed)
├── view_model/            # 비즈니스 로직 (Riverpod)
├── views/                 # UI 레이어
├── repository/            # 데이터 접근 추상화
├── service/               # API 클라이언트 (Retrofit)
└── shared/                # 공통 모델, 위젯, 프로바이더
```

### 레이어 흐름

```
View (views/)
  ↓
ViewModel (view_model/)  ← Riverpod Provider
  ↓
Repository (repository/)
  ↓
Service/API (service/)   ← Retrofit + Dio
  ↓
Backend REST API
```

## 네이밍 컨벤션

| 유형 | 패턴 | 예시 |
|------|------|------|
| 화면 | `*_page.dart` | `duty_page.dart` |
| 뷰모델 | `*_view_model.dart` | `duty_view_model.dart` |
| 레포지토리 | `*_repository.dart` | `duty_repository.dart` |
| API | `*_api.dart` | `duty_api.dart` |
| 모델 | `*_model.dart` | `duty_model.dart` |
| 위젯 | `*_widget.dart` | `duty_card_widget.dart` |

## 코드 생성

`freezed`, `retrofit`, `riverpod_generator`는 코드 생성을 사용합니다.

```bash
# 코드 생성 (일회성)
dart run build_runner build --delete-conflicting-outputs

# 코드 생성 (감시 모드)
dart run build_runner watch --delete-conflicting-outputs
```

## 시작하기

### 요구사항

- Flutter SDK `^3.6.1`
- Dart SDK `^3.6.1`

### 설치 및 실행

```bash
# 1. 의존성 설치
flutter pub get

# 2. 코드 생성 (freezed, retrofit, riverpod_generator)
dart run build_runner build --delete-conflicting-outputs

# 3. 앱 실행
flutter run
```

> **참고**: freezed, retrofit, riverpod_generator를 사용하므로 코드 생성 단계(2번)가 필수입니다.

### 개발 중 코드 생성 자동화

```bash
# 파일 변경 감지해서 자동 재생성
dart run build_runner watch --delete-conflicting-outputs
```

### 플랫폼별 빌드

```bash
# iOS
flutter build ios

# Android
flutter build apk          # APK
flutter build appbundle    # AAB (Play Store용)
```

## 환경 설정

`lib/shared/network_provider.dart`에서 API 기본 URL을 설정합니다.

```dart
// Android 에뮬레이터: 10.0.2.2
// iOS 시뮬레이터 / 실제 기기: localhost 또는 실제 IP
var localhost = "localhost";

if (defaultTargetPlatform == TargetPlatform.android) {
  localhost = "10.0.2.2";
}
```

## 주요 패턴

### Riverpod ViewModel

```dart
@freezed
class DutyState with _$DutyState {
  factory DutyState({@Default([]) List<DutyModel> duties}) = _DutyState;
}

@riverpod
class DutyViewModel extends _$DutyViewModel {
  @override
  DutyState build() {
    return const DutyState();
  }
}
```

### Freezed 모델

```dart
@freezed
class DutyModel with _$DutyModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DutyModel({
    int? id,
    String? title,
    String? date,
  }) = _DutyModel;

  factory DutyModel.fromJson(Map<String, dynamic> json) =>
      _$DutyModelFromJson(json);
}
```

### Retrofit API

```dart
@RestApi()
abstract class DutyApi {
  factory DutyApi(Dio dio, {String baseUrl}) = _DutyApi;

  @GET("/duties")
  Future<List<DutyModel>> getDuties();
}
```
