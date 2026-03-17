<div align="center">

```
██████╗ ██╗   ██╗████████╗██╗   ██╗
██╔══██╗██║   ██║╚══██╔══╝╚██╗ ██╔╝
██║  ██║██║   ██║   ██║    ╚████╔╝
██║  ██║██║   ██║   ██║     ╚██╔╝
██████╔╝╚██████╔╝   ██║      ██║
╚═════╝  ╚═════╝    ╚═╝      ╚═╝
 ██████╗██╗  ██╗███████╗ ██████╗██╗  ██╗███████╗██████╗
██╔════╝██║  ██║██╔════╝██╔════╝██║ ██╔╝██╔════╝██╔══██╗
██║     ███████║█████╗  ██║     █████╔╝ █████╗  ██████╔╝
██║     ██╔══██║██╔══╝  ██║     ██╔═██╗ ██╔══╝  ██╔══██╗
╚██████╗██║  ██║███████╗╚██████╗██║  ██╗███████╗██║  ██║
 ╚═════╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
```

### 당사자와 보호자를 연결하는 스마트 안심 케어 플랫폼

<br/>

[![Flutter](https://img.shields.io/badge/Flutter-3.6.1+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Riverpod](https://img.shields.io/badge/Riverpod-2.5.1-00BCD4?style=for-the-badge&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==&logoColor=white)](https://riverpod.dev)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
[![Version](https://img.shields.io/badge/Version-1.0.0-orange?style=for-the-badge)](pubspec.yaml)

<br/>

[📱 주요 기능](#-주요-기능) · [🏗 아키텍처](#-아키텍처) · [🚀 시작하기](#-시작하기) · [📦 기술 스택](#-기술-스택) · [📁 프로젝트 구조](#-프로젝트-구조)

</div>

---

## 🌟 프로젝트 소개

> **Duty Checker**는 일상의 안심을 연결합니다.

당사자(개인)와 보호자 사이의 **일상 안부 확인 및 케어 모니터링** 앱입니다.
매일의 체크인, 안부 확인, 응급 상황 알림을 통해 떨어져 있어도 함께하는 느낌을 선사합니다.

```
╔══════════════════════════════════════════════════════════════╗
║                                                              ║
║   👤 당사자 (Self)        🛡️ 보호자 (Guardian)              ║
║                                                              ║
║   · 일상 안부 체크인     · 실시간 상태 모니터링              ║
║   · 보호자 등록 (최대 5명) · 미응답 알림 수신               ║
║   · 간편 본인 인증       · 여러 당사자 관리                  ║
║                                                              ║
╚══════════════════════════════════════════════════════════════╝
```

---

## 📱 주요 기능

<table>
<tr>
<td width="50%" align="center">

### 🏠 역할 선택 화면

```
┌─────────────────────────┐
│                         │
│    Duty Checker         │
│                         │
│  ┌─────────┐            │
│  │  👤     │            │
│  │ 당사자  │            │
│  └─────────┘            │
│                         │
│  ┌─────────┐            │
│  │  🛡️    │            │
│  │ 보호자  │            │
│  └─────────┘            │
│                         │
│  [ 다음으로 → ]         │
└─────────────────────────┘
```

</td>
<td width="50%" align="center">

### 📝 회원가입 (3단계)

```
┌─────────────────────────┐
│  ●───●───●              │
│  1   2   3              │
│                         │
│  Step 1: 휴대폰 번호    │
│  ┌──────────────────┐   │
│  │ 010-XXXX-XXXX    │   │
│  └──────────────────┘   │
│                         │
│  Step 2: 인증번호       │
│  ┌──────────────────┐   │
│  │ ○ ○ ○ ○ ○ ○     │   │
│  └──────────────────┘   │
│                         │
│  Step 3: 보호자 등록    │
│  ┌──────────────────┐   │
│  │ + 보호자 추가    │   │
│  └──────────────────┘   │
└─────────────────────────┘
```

</td>
</tr>
</table>

### ✨ 핵심 UX 특징

| 기능 | 설명 |
|------|------|
| 🎯 **스마트 OTP** | 6자리 입력 시 자동 제출 |
| 📱 **번호 자동 포맷** | 010-XXXX-XXXX 실시간 포맷팅 |
| 🎨 **부드러운 애니메이션** | 단계 전환 시 Slide + Fade 트랜지션 |
| ⌨️ **키보드 감지** | 키보드 등장 시 자동 스크롤 포커싱 |
| 👥 **보호자 다중 등록** | 최대 5명의 보호자 등록 가능 |

---

## 🏗 아키텍처

**Clean Architecture** 원칙을 철저히 따르는 레이어드 아키텍처 구조입니다.

```
┌─────────────────────────────────────────────────────────┐
│                   PRESENTATION LAYER                    │
│                                                         │
│    Pages         Widgets        ViewModels              │
│   ┌──────┐      ┌──────┐       ┌──────────┐           │
│   │ Page │      │Widget│       │ Provider │           │
│   └──────┘      └──────┘       └──────────┘           │
│                       │                                 │
│              (Riverpod State Management)                │
└───────────────────────┼─────────────────────────────────┘
                        │ depends on
┌───────────────────────▼─────────────────────────────────┐
│                    DOMAIN LAYER                         │
│                 (Pure Dart - No Flutter)                │
│                                                         │
│    Entities        Use Cases      Repositories          │
│   ┌──────┐       ┌──────────┐    ┌────────────┐       │
│   │Entity│       │ UseCase  │    │  Interface │       │
│   └──────┘       └──────────┘    └────────────┘       │
└───────────────────────┼─────────────────────────────────┘
                        │ implements
┌───────────────────────▼─────────────────────────────────┐
│                     DATA LAYER                          │
│                                                         │
│     DTOs          Repositories      Data Sources        │
│   ┌──────┐       ┌────────────┐    ┌────────────┐      │
│   │ DTO  │       │  RepoImpl  │    │  Remote/   │      │
│   └──────┘       └────────────┘    │  Local API │      │
│                                    └────────────┘      │
└─────────────────────────────────────────────────────────┘
```

### 📐 피처 기반 구조

```
lib/
 ├── 🔵 guardian/          # 보호자 피처
 │    ├── data/            # Repository 구현, DTO, API
 │    ├── domain/          # Entity, UseCase, Interface
 │    └── presentation/    # Page, Widget, ViewModel
 │
 ├── 🟢 self/              # 당사자 피처
 │    └── presentation/    # Page, Widget, ViewModel
 │
 └── 🟡 shared/            # 공통 유틸리티
```

---

## 📦 기술 스택

<table>
<tr>
<th>Category</th>
<th>Package</th>
<th>Version</th>
<th>Purpose</th>
</tr>
<tr>
<td rowspan="2"><b>🔄 State Management</b></td>
<td><code>flutter_riverpod</code></td>
<td>^2.5.1</td>
<td>리액티브 상태 관리</td>
</tr>
<tr>
<td><code>riverpod_generator</code></td>
<td>^2.3.9</td>
<td>Provider 코드 생성</td>
</tr>
<tr>
<td><b>🧭 Navigation</b></td>
<td><code>go_router</code></td>
<td>^14.1.4</td>
<td>타입 안전 라우팅</td>
</tr>
<tr>
<td rowspan="2"><b>🌐 Network</b></td>
<td><code>dio</code></td>
<td>^5.4.3+1</td>
<td>HTTP 클라이언트</td>
</tr>
<tr>
<td><code>retrofit</code></td>
<td>^4.1.0</td>
<td>타입 안전 REST API</td>
</tr>
<tr>
<td rowspan="3"><b>🧊 Serialization</b></td>
<td><code>freezed_annotation</code></td>
<td>^2.4.1</td>
<td>불변 클래스 생성</td>
</tr>
<tr>
<td><code>json_annotation</code></td>
<td>^4.9.0</td>
<td>JSON 직렬화</td>
</tr>
<tr>
<td><code>freezed</code></td>
<td>^2.4.1</td>
<td>Immutable 클래스 코드 생성</td>
</tr>
<tr>
<td><b>💾 Storage</b></td>
<td><code>shared_preferences</code></td>
<td>^2.2.3</td>
<td>로컬 키-값 저장소</td>
</tr>
<tr>
<td rowspan="4"><b>🎨 UI</b></td>
<td><code>flutter_svg</code></td>
<td>^2.0.10+1</td>
<td>SVG 렌더링</td>
</tr>
<tr>
<td><code>cached_network_image</code></td>
<td>^3.3.1</td>
<td>이미지 캐싱</td>
</tr>
<tr>
<td><code>dotted_border</code></td>
<td>^2.1.0</td>
<td>점선 테두리</td>
</tr>
<tr>
<td><code>gap</code></td>
<td>^3.0.1</td>
<td>간격 위젯</td>
</tr>
<tr>
<td><b>🌍 i18n</b></td>
<td><code>intl</code></td>
<td>^0.19.0</td>
<td>국제화 지원</td>
</tr>
</table>

---

## 🎨 디자인 시스템

**토스(Toss) 디자인 시스템**에서 영감을 받은 컬러 팔레트와 타이포그래피를 사용합니다.

```
COLOR PALETTE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Primary    ████ #3182F6   Toss Blue
  Background ████ #F2F4F6   Light Gray
  Surface    ████ #FFFFFF   White
  ─────────────────────────────────────────
  Text/1     ████ #191F28   Primary Text
  Text/2     ████ #6B7684   Secondary Text
  Text/3     ████ #8B95A1   Tertiary Text
  ─────────────────────────────────────────
  Success    ████ #00C471   Green
  Error      ████ #F04452   Red
  Warning    ████ #FF9500   Orange

TYPOGRAPHY  ·  Pretendard Font Family
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Display    28px / Bold     (700)
  Heading1   24px / Bold     (700)
  Heading2   20px / SemiBold (600)
  Heading3   18px / SemiBold (600)
  Body1      16px / Regular  (400)
  Body2      14px / Regular  (400)
  Caption    12px / Medium   (500)
```

---

## 🚀 시작하기

### 사전 요구사항

```bash
# Flutter SDK 확인
flutter --version  # 3.6.1 이상 필요

# Flutter doctor
flutter doctor
```

### 설치 및 실행

```bash
# 1. 저장소 클론
git clone https://github.com/your-org/duty_checker.git
cd duty_checker

# 2. 의존성 설치
flutter pub get

# 3. 코드 생성 (freezed, riverpod, retrofit)
dart run build_runner build --delete-conflicting-outputs

# 4. 앱 실행
flutter run
```

### 빌드

```bash
# iOS 빌드
flutter build ios

# Android APK
flutter build apk

# Android App Bundle (Play Store)
flutter build appbundle
```

### 개발 중 코드 생성 (Watch 모드)

```bash
dart run build_runner watch --delete-conflicting-outputs
```

---

## 📁 프로젝트 구조

```
duty_checker/
│
├── 📁 assets/
│   └── 📁 fonts/                    # Pretendard 폰트 (400, 500, 600, 700)
│
├── 📁 docs/
│   ├── 📄 CLEAN_ARCHITECTURE.md     # 아키텍처 가이드
│   └── 📄 CONVENTION.md             # 코드 컨벤션
│
├── 📁 lib/
│   ├── 📄 main.dart                 # 앱 진입점 & Provider 초기화
│   ├── 📄 router.dart               # GoRouter 네비게이션 설정
│   ├── 📄 theme.dart                # 디자인 시스템 & 컬러/타입
│   │
│   ├── 📁 guardian/                 # 🛡️ 보호자 피처
│   │   ├── 📁 data/
│   │   │   ├── datasource/          # Remote/Local 데이터 소스
│   │   │   ├── dto/                 # 데이터 전송 객체
│   │   │   └── repository/         # Repository 구현체
│   │   ├── 📁 domain/
│   │   │   ├── entity/              # 도메인 엔티티
│   │   │   ├── repository/         # Repository 인터페이스
│   │   │   └── use_case/           # 비즈니스 로직
│   │   └── 📁 presentation/
│   │       ├── page/                # 화면 (LandingPage, SignUpPage)
│   │       └── widget/              # 재사용 위젯
│   │
│   ├── 📁 self/                     # 👤 당사자 피처
│   │   └── 📁 presentation/
│   │       └── page/                # SelfSignUpPage
│   │
│   └── 📁 shared/                   # 🔧 공통 유틸리티
│       └── shared_preferences_provider.dart
│
├── 📄 pubspec.yaml                  # 프로젝트 설정 & 의존성
└── 📄 analysis_options.yaml         # 린트 규칙
```

---

## 🗺️ 라우팅 구조

```
/landing                  ← 시작 화면 (역할 선택)
     │
     ├── /sign-up/self    ← 당사자 회원가입 (3단계)
     │        ├── Step 1: 전화번호 입력
     │        ├── Step 2: OTP 인증
     │        └── Step 3: 보호자 등록
     │
     └── /sign-up/guardian ← 보호자 회원가입
```

---

## 📊 개발 현황

```
PROGRESS ████████░░░░░░░░░░░░  40%
```

| 기능 | 상태 |
|------|------|
| 🏠 역할 선택 화면 | ✅ 완료 |
| 📝 당사자 회원가입 (3단계) | ✅ 완료 |
| 📱 전화번호 인증 UX | ✅ 완료 |
| 🏗️ Clean Architecture 설정 | ✅ 완료 |
| 🎨 디자인 시스템 | ✅ 완료 |
| 🧭 라우팅 인프라 | ✅ 완료 |
| 🛡️ 보호자 회원가입 | 🔄 진행 중 |
| 🔐 인증 플로우 완성 | 📋 예정 |
| 📊 보호자 모니터링 대시보드 | 📋 예정 |
| ✅ 일상 체크인 기능 | 📋 예정 |
| 🔔 푸시 알림 | 📋 예정 |
| 🧪 테스트 코드 | 📋 예정 |

---

## 🧑‍💻 개발 컨벤션

상세한 가이드는 [`docs/`](./docs/) 폴더를 참조하세요.

### 파일 네이밍
```
snake_case       → 파일명  (home_page.dart)
PascalCase       → 클래스명 (HomePage)
snake_case       → 변수/함수 (getUserData)
```

### Use Case 동사 패턴
```
Get    → 단일 조회    (GetUserUseCase)
Fetch  → 목록 조회    (FetchGuardiansUseCase)
Create → 생성         (CreateCheckInUseCase)
Update → 수정         (UpdateProfileUseCase)
Delete → 삭제         (DeleteGuardianUseCase)
```

---

## 🤝 기여하기

1. `Fork` the project
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a `Pull Request`

---

## 📄 라이선스

이 프로젝트는 MIT 라이선스를 따릅니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

---

<div align="center">

**Duty Checker** — 일상의 안심을 연결합니다 ❤️

<br/>

[![Flutter](https://img.shields.io/badge/Made%20with-Flutter-02569B?style=flat-square&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Powered%20by-Dart-0175C2?style=flat-square&logo=dart)](https://dart.dev)

</div>
