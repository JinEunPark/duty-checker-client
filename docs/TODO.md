# API 연동 TODO (화면 기능 단위)

## 인프라 (완료)
- [x] `core/network/` — Dio provider, AuthInterceptor, TokenStorage
- [x] `core/fcm/` — FcmService, DeviceTokenApi, FCM 토큰 서버 등록
- [x] `auth/` — domain + data 레이어 전체 (Entity, Repository, UseCase, DTO, API, DataSource)

---

## 1. 당사자 회원가입 (`self_sign_up_page.dart`)

| 기능 | API | 상태 |
|------|-----|------|
| 전화번호 인증코드 발송 | `POST /v1/auth/send-code` | ✅ 연결됨 |
| 인증코드 검증 | `POST /v1/auth/verify-code` | ✅ 연결됨 |
| 회원가입 | `POST /v1/auth/register` (role: SUBJECT) | ✅ 연결됨 |
| 가입 후 자동 로그인 | `POST /v1/auth/login` | ✅ 연결됨 — 회원가입 성공 후 같은 phone/password로 자동 로그인 |
| 보호자 전화번호 추가 | `POST /v1/connections` | ✅ 연결됨 — 자동 로그인 후 `_guardians` 리스트를 순회하며 API 호출 |
| 가입 완료 후 홈 이동 | — | ✅ 변경됨 — 완료 화면에서 role 기반 홈(`/user/home`)으로 이동 |

**필요한 feature**: auth (✅ 완료), connection (✅ 완료)

---

## 2. 보호자 회원가입 (`guardian_sign_up_page.dart`)

| 기능 | API | 상태 |
|------|-----|------|
| 전화번호 인증코드 발송 | `POST /v1/auth/send-code` | ✅ 연결됨 |
| 인증코드 검증 | `POST /v1/auth/verify-code` | ✅ 연결됨 |
| 회원가입 | `POST /v1/auth/register` (role: GUARDIAN) | ✅ 연결됨 |
| 가입 후 자동 로그인 | `POST /v1/auth/login` | ✅ 연결됨 — 회원가입 성공 후 자동 로그인 |
| 가입 완료 후 홈 이동 | — | ✅ 변경됨 — 완료 화면에서 `/guardian/home`으로 이동 |

**필요한 feature**: auth (기존)

---

## 3. 로그인 (`login_page.dart`)

| 기능 | API | 상태 |
|------|-----|------|
| 로그인 | `POST /v1/auth/login` | ✅ 연결됨 |
| 역할별 홈 분기 | 응답의 `user.role` 기반 | ✅ 연결됨 |
| 로그인 후 FCM 토큰 전송 | `PATCH /v1/users/device-token` | ✅ 연결됨 — 로그인 성공 시 `fcmService.connectApi()` 호출 |

**필요한 feature**: auth (기존), user (신규)

---

## 4. 스플래시 (`splash_page.dart`)

| 기능 | API | 상태 |
|------|-----|------|
| 토큰 유무 확인 → 자동 분기 | 없음 (로컬 토큰 확인) | ✅ 연결됨 |
| 역할별 홈 분기 | 저장된 role 기반 | ✅ 연결됨 — TokenStorage에 role 저장, splash에서 role 기반 분기 |

**필요한 feature**: auth (✅ 완료)

---

## 5. 당사자 홈 (`user_home_page.dart`)

| 기능 | API | 상태 |
|------|-----|------|
| 안부 확인 버튼 (체크인) | `POST /v1/check-ins` | ✅ 연결됨 — `checkInViewModelProvider` 사용 |
| 마지막 안부 시각 표시 | `GET /v1/check-ins/latest` | ✅ 연결됨 — API에서 `latestCheckedAt` 조회 |
| 보호자 연결 상태 카운트 | `GET /v1/connections` | ✅ 연결됨 — `connectionViewModelProvider` 사용 |

**필요한 feature**: check_in (✅ 완료), connection (✅ 완료)

---

## 6. 보호자 홈 (`guardian_home_page.dart`)

| 기능 | API | 상태 |
|------|-----|------|
| 연결된 당사자 목록 + 안부 상태 표시 | `GET /v1/connections` | ✅ 연결됨 — `connectionViewModelProvider` 사용 |
| 당사자별 마지막 안부 시각 | `GET /v1/connections`의 `latestCheckedAt` | ✅ 연결됨 |
| 긴급 알림 (48시간 미확인) | `GET /v1/connections`의 `isTodayChecked` | ✅ 연결됨 |

**필요한 feature**: connection (✅ 완료)

---

## 7. 보호자 관리 — 당사자용 (`guardian_management_page.dart`)

| 기능 | API | 상태 |
|------|-----|------|
| 보호자 목록 조회 | `GET /v1/connections` | ✅ 연결됨 — `connectionViewModelProvider` 사용 |
| 보호자 추가 (전화번호) | `POST /v1/connections` | ✅ 연결됨 — `addConnection(guardianPhone:)` |
| 보호자 별칭 수정 | `PATCH /v1/connections/{id}/name` | ✅ 연결됨 — `updateConnectionName(id, name)` |

**필요한 feature**: connection (✅ 완료)

---

## 8. 당사자 관리 — 보호자용 (`user_management_page.dart`)

| 기능 | API | 상태 |
|------|-----|------|
| 연결된 당사자 목록 | `GET /v1/connections` | ✅ 연결됨 — `connectionViewModelProvider` 사용, `isConnected` 필터링 |
| 대기 중인 초대 목록 | `GET /v1/connections` (status: PENDING) | ✅ 연결됨 — `isPending` 필터링 |
| 호칭 편집 | `PATCH /v1/connections/{id}/name` | ✅ 연결됨 — `updateConnectionName(id, name)` |

**필요한 feature**: connection (✅ 완료)

---

## 9. 설정 (`settings_action_sheet.dart`)

| 기능 | API | 상태 |
|------|-----|------|
| 로그아웃 | `POST /v1/auth/logout` | ✅ 연결됨 — `LogoutUseCase`로 서버 로그아웃 + 토큰 삭제 |
| 역할 전환 | 없음 (로컬 라우팅) | ✅ 동작함 |

**필요한 feature**: auth (기존 LogoutUseCase 연결만)

---

## 10. FCM 토큰 (백그라운드)

| 기능 | API | 상태 |
|------|-----|------|
| 로그인/앱 시작 시 토큰 전송 | `PATCH /v1/users/device-token` | ✅ 연결됨 — `FcmService.connectApi()` 호출 시 즉시 전송 |
| 토큰 갱신 시 서버 업데이트 | `PATCH /v1/users/device-token` | ✅ 연결됨 — `onTokenRefresh` 리스너에서 자동 전송 |

**구현 위치**: `core/fcm/` (공통 인프라, user feature 불필요)

---

## 신규 feature 구현 필요 목록

### ~~connection feature~~ ✅ 완료
- domain + data 레이어 구현 완료, 보호자 홈/보호자 관리/당사자 관리 화면 연결 완료
- 남은 작업: 회원가입 스텝4 보호자 추가 시 `POST /v1/connections` API 연결

### ~~check_in feature~~ ✅ 완료
- domain + data 레이어 구현 완료, 당사자 홈 화면 연결 완료

### ~~user feature (백그라운드)~~ ✅ 완료
- ~~사용 API: `PATCH /v1/users/device-token`~~
- `core/fcm/`에서 구현 완료 (공통 인프라로 처리)

---

## 공통 개선
- [x] 토큰 자동 갱신 인터셉터 (401 → `POST /v1/auth/refresh` → 재요청) — `AuthInterceptor.onError` 구현 완료
- [x] API 에러 공통 처리 (`core/error/app_error.dart` — `AppError.from()` + `AppErrorType` enum 구현 완료)
- [x] splash에서 role 기반 홈 분기 (TokenStorage에 role 저장 + splash 분기 구현 완료)

---

## 남은 작업 순서

1. ~~**회원가입 보호자 추가 API 연결**~~ ✅ 완료 — 회원가입 후 자동 로그인 + `POST /v1/connections` 호출 + 홈으로 이동
2. ~~**설정 로그아웃 개선**~~ ✅ 완료 — `LogoutUseCase` 연결, 서버 실패해도 토큰 삭제 보장
3. ~~**토큰 자동 갱신 인터셉터**~~ ✅ 완료 — `AuthInterceptor.onError`에서 401 감지 → refresh → 재요청

---

# 🍎 App Store 심사 준비 (필수)

App Store 심사 통과를 위한 작업 목록. **우선순위 순**으로 정리.

## A. 심사 거절 직결 항목 (반드시 해야 함)

### A-1. 회원 탈퇴 기능 구현 ❌ 필수
**Apple Guideline 5.1.1(v)**: 계정 생성 가능한 앱은 **반드시 앱 내에서 계정을 삭제할 수 있어야** 함.

- [ ] 백엔드: 회원 탈퇴 API 추가 요청 (예: `DELETE /v1/users/me`)
  - 사용자 본인의 데이터(연결, 체크인 기록 포함) 모두 삭제
  - 인증된 사용자만 호출 가능
- [ ] 클라이언트: `user` feature 추가
  - `lib/user/domain/repository/user_repository.dart` (interface)
  - `lib/user/domain/use_case/delete_account_use_case.dart`
  - `lib/user/data/api/user_api.dart` (Retrofit)
  - `lib/user/data/datasource/user_remote_datasource.dart`
  - `lib/user/data/repository/user_repository_impl.dart`
- [ ] `setting_page.dart` `_onDeleteAccount()` 수정
  - 현재: `tokenStorage.clear()`만 호출
  - 변경: `DeleteAccountUseCase` 호출 → 토큰 삭제 → `/login` 이동
  - 확인 다이얼로그 문구 강화: "탈퇴 시 모든 안부 기록과 보호자 연결이 영구 삭제되며, 복구할 수 없습니다."
- [ ] 단위 테스트 추가

### A-2. 개인정보 처리방침 (Privacy Policy) ❌ 필수
**Apple Guideline 5.1.1(i)**: 개인정보를 수집하는 모든 앱은 **개인정보 처리방침 URL** 필수.

- [ ] 개인정보 처리방침 작성 (수집 항목, 이용 목적, 보관 기간, 제3자 제공 등 포함)
  - 수집 항목: 전화번호, FCM 디바이스 토큰, 안부 체크인 기록, 보호자 연결 정보
  - 제3자: Firebase (FCM 푸시 알림)
- [ ] 호스팅 (예: GitHub Pages, 회사 웹사이트, Notion 공개 페이지)
- [ ] App Store Connect 제출 시 Privacy Policy URL 입력
- [ ] **앱 내 표시 (선택이지만 권장)**:
  - 설정 화면에 "개인정보 처리방침" 메뉴 추가
  - 회원가입 화면에 동의 체크박스 + 링크
  - `url_launcher`로 외부 브라우저 또는 `WebView`로 표시

### A-3. 이용약관 (Terms of Service) ❌ 필수
- [ ] 이용약관 작성 및 호스팅
- [ ] 회원가입 화면에 동의 체크박스 추가 (개인정보 처리방침과 함께)
- [ ] 설정 화면에 "이용약관" 메뉴 추가

### A-4. PrivacyInfo.xcprivacy 파일 작성 ⚠️ 필수 (iOS 17+)
**Apple 요구사항**: 2024년 5월부터 모든 신규 앱/업데이트는 Privacy Manifest 필수.

- [ ] `ios/Runner/PrivacyInfo.xcprivacy` 생성
  - **NSPrivacyTracking**: false (트래킹 안 함)
  - **NSPrivacyCollectedDataTypes**: 수집하는 데이터 타입 선언
    - Phone Number (전화번호)
    - Device ID (FCM 토큰 — 식별자로 분류)
    - Other User Content (체크인 기록)
  - **NSPrivacyAccessedAPITypes**: 사용한 Required Reason API 선언
    - `NSPrivacyAccessedAPICategoryUserDefaults` (shared_preferences)
    - 필요시 추가
- [ ] Xcode 프로젝트에 파일 등록 (Build Phases → Copy Bundle Resources)

### A-5. App Store Connect 메타데이터 ❌ 필수
- [ ] 앱 이름: "오늘안부" (한글) / "Duty Checker" (영문)
- [ ] 부제목 (Subtitle, 30자)
- [ ] 카테고리: Health & Fitness 또는 Lifestyle
- [ ] 키워드 (100자, 쉼표 구분)
- [ ] 앱 설명 (한글/영문, 4000자 이내)
- [ ] 프로모션 텍스트 (170자)
- [ ] **연령 등급 설문**: 4+ 적합 (안부 확인 앱)
- [ ] 지원 URL (필수)
- [ ] 마케팅 URL (선택)
- [ ] 저작권 표기

### A-6. 스크린샷 ❌ 필수
- [ ] 6.9" iPhone 17 Pro Max — 최소 3장 (필수, 최대 10장)
  - 1290 × 2796 px
- [ ] 6.5" iPhone 11 Pro Max — 필요한 경우
- [ ] 5.5" iPhone 8 Plus — 필요한 경우 (구형 대응)
- [ ] 권장 화면: 스플래시 → 회원가입 흐름 → 당사자 홈 → 보호자 홈 → 보호자 관리

---

## B. 권한 / 설정 (빌드 거부 방지)

### B-1. Info.plist 권한 사용 설명 추가 ❌
사용 중인 권한이 Info.plist에 명시되지 않으면 빌드/심사 거절됨.

- [ ] **NSUserNotificationsUsageDescription** (FCM 푸시 알림 — 사실상 의무는 아니나 권장)
  - 이미 `firebase_messaging`이 자동 처리하지만 사용자 친화 문구 권장
- [ ] **image_picker 사용 여부 확인**:
  - 만약 사용한다면 `NSCameraUsageDescription`, `NSPhotoLibraryUsageDescription` 추가
  - 사용하지 않는다면 `pubspec.yaml`에서 의존성 **제거 권장** (불필요한 권한 트리거 방지)
- [ ] **`tel`, `sms` URL Scheme**: ✅ 이미 LSApplicationQueriesSchemes에 등록됨

### B-2. 푸시 알림 권한 요청 시점 개선 ⚠️
현재 `main.dart`에서 앱 시작 즉시 권한 요청 → 사용자가 거부할 가능성 높음.

- [ ] 권한 요청 시점을 **로그인 직후** 또는 **온보딩 화면**으로 변경
- [ ] 권한 거부 시 친절한 안내 (설정에서 변경 가능 메시지)

### B-3. 푸시 알림 메시지 카테고리 / 액션 (선택)
- [ ] 안부 미확인 알림 (보호자용) 메시지 포맷 정의
- [ ] 알림 탭 시 해당 화면으로 딥링크

---

## C. 빌드 / 배포 설정

### C-1. 버전 관리
- [ ] `pubspec.yaml`의 `version` 정책 정립 (예: 1.0.0+1 → 1.0.0+2)
- [ ] CHANGELOG 작성 (선택)

### C-2. Bundle ID & 서명
- [x] Bundle ID: `com.couper.dutyChecker` 확정됨
- [x] DEVELOPMENT_TEAM: `RZRDYS2RA7` 설정됨
- [ ] **App Store Connect에 앱 등록** (Bundle ID 미리 reserved)
- [ ] **Distribution Certificate** 발급 (Apple Developer Portal)
- [ ] **App Store Provisioning Profile** 생성
- [ ] Xcode → Signing & Capabilities → "Automatically manage signing" 또는 수동 프로파일 지정

### C-3. Capabilities 설정 확인
- [x] Push Notifications (Capability 활성화 필요)
- [x] Background Modes → Remote notifications
- [ ] Xcode에서 Apple Developer Portal과 동기화 확인

### C-4. 런치 스크린 ⚠️
- [ ] 현재 `LaunchImage.imageset`이 플레이스홀더 (68 bytes 빈 파일)
- [ ] `LaunchScreen.storyboard` 사용 확인 → 실제 스토리보드에 앱 로고/색상 반영
- [ ] 또는 `LaunchImage.png` 실제 이미지로 교체

### C-5. 앱 아이콘
- [x] `AppIcon.appiconset` 모든 크기 등록 완료
- [ ] **1024×1024 마케팅 아이콘**에 alpha 채널 없는지 재확인 (App Store 거절 사유 1순위)
- [ ] 아이콘이 최종 디자인인지 확인

---

## D. 기능 안정성 / UX 개선 (심사 직접 거절은 아니나 권장)

### D-1. 이미 체크인한 상태 UX 개선 ⚠️
현재 `user_home_page.dart`에서 이미 체크인한 사용자가 버튼 다시 누르면 silently 무시됨 → 혼란 유발.

- [ ] `_justChecked` 분기와 별도로 `state.todayChecked == true`인 경우:
  - 버튼 비활성화 또는 다른 색상으로 표시
  - "오늘은 이미 안부를 전달했어요" 안내 표시
  - 다음 체크인 가능 시각 안내 (자정 이후 등)

### D-2. 네트워크 에러 / 로딩 UX
- [ ] 모든 화면에서 로딩 상태 인디케이터 일관성 점검
- [ ] 네트워크 오프라인 상태 감지 및 안내
- [ ] Retry 버튼 제공

### D-3. 빈 상태 일러스트
- [x] 보호자 홈 (연결된 당사자 없음): 구현됨
- [ ] 당사자 홈 (보호자 없음): 안내 추가
- [ ] 보호자 관리 화면 (목록 비었을 때)

### D-4. 회원가입 약관 동의 UI
- [ ] `self_sign_up_page.dart`, `guardian_sign_up_page.dart` 마지막 단계에 **약관 동의 체크박스** 추가
  - [ ] 만 14세 이상 동의 (필수)
  - [ ] 이용약관 동의 (필수, 링크)
  - [ ] 개인정보 처리방침 동의 (필수, 링크)
  - [ ] 마케팅 정보 수신 동의 (선택)

### D-5. 푸시 알림 권한 거부 시 처리
- [ ] 알림 권한 거부 상태에서도 앱 사용 가능하도록 (현재도 가능하나 안내 부족)
- [ ] 설정 화면에서 알림 권한 상태 표시 + iOS 설정으로 이동 버튼

---

## E. 심사 제출 직전 체크리스트

### E-1. 빌드
- [ ] `flutter build ipa --release` 성공
- [ ] `flutter analyze` 클린
- [ ] `flutter test` 전체 통과

### E-2. TestFlight 내부 테스트
- [ ] App Store Connect → TestFlight 업로드
- [ ] 내부 테스터로 등록 후 실기기 테스트
- [ ] 회원가입/로그인/체크인/보호자 연결 전체 플로우 검증
- [ ] 푸시 알림 수신 검증

### E-3. 심사 정보 (App Review Information)
- [ ] **테스트 계정 제공 필수** (전화번호 인증 우회 가능한 데모 계정 또는 인증 코드 제공 방법 안내)
  - 심사관이 SMS를 받을 수 없으므로 **인증 우회 방법 또는 데모 계정 필수**
- [ ] 연락처 정보 (이름, 전화, 이메일)
- [ ] 메모: 앱의 목적과 사용 시나리오 간단 설명 (영문)

### E-4. 광고 식별자 (IDFA)
- [ ] App Store Connect 제출 시 "이 앱은 광고 식별자(IDFA)를 사용하는가?" → **아니요** 선택
  - 현재 `firebase_messaging`만 사용하고 광고 SDK 없음

### E-5. 수출 규정 (Export Compliance)
- [ ] HTTPS만 사용하므로 표준 암호화 → "Yes, but uses standard exemption" 선택 가능

---

## 우선순위 요약

### 🔴 **반드시 해야 함 (심사 거절 직결)**
1. 회원 탈퇴 기능 구현 (서버 API + 클라이언트)
2. 개인정보 처리방침 작성 + URL 제공
3. 이용약관 작성 + 회원가입 동의 UI
4. PrivacyInfo.xcprivacy 작성
5. 테스트 계정 제공 또는 SMS 인증 우회 방법

### 🟡 **빌드/배포에 필요**
6. App Store Connect 앱 등록 + 메타데이터 입력
7. 스크린샷 제작
8. 1024 아이콘 alpha 채널 확인
9. 런치 스크린 실제 이미지 교체
10. Distribution 인증서/프로비저닝 프로파일

### 🟢 **권장 (심사 통과 후 개선)**
11. 이미 체크인 상태 UX 개선
12. 푸시 권한 요청 시점 개선
13. 네트워크 에러 / 빈 상태 UI
14. 약관 동의 화면

---

## 참고
- App Store Review Guidelines: https://developer.apple.com/app-store/review/guidelines/
- 한국어 번역: https://developer.apple.com/kr/app-store/review/guidelines/
- Privacy Manifest 가이드: https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
