# TODO — 오늘안부 (duty_checker)

---

## API 연동 (완료)

- [x] `core/network/` — Dio provider, AuthInterceptor, TokenStorage
- [x] `core/fcm/` — FcmService, DeviceTokenApi, FCM 토큰 서버 등록
- [x] `auth/` — domain + data 레이어 전체
- [x] `connection/` — domain + data 레이어 + 화면 연결
- [x] `check_in/` — domain + data 레이어 + 당사자 홈 연결
- [x] `user/` — FCM 디바이스 토큰 (core/fcm에서 처리)

### 당사자 회원가입 (`self_sign_up_page.dart`)
- [x] 전화번호 인증코드 발송 — `POST /v1/auth/send-code`
- [x] 인증코드 검증 — `POST /v1/auth/verify-code`
- [x] 회원가입 — `POST /v1/auth/register` (role: SUBJECT)
- [x] 가입 후 자동 로그인 — `POST /v1/auth/login`
- [x] 보호자 전화번호 추가 — `POST /v1/connections`
- [x] 가입 완료 후 홈 이동 — role 기반 `/user/home`

### 보호자 회원가입 (`guardian_sign_up_page.dart`)
- [x] 전화번호 인증코드 발송 — `POST /v1/auth/send-code`
- [x] 인증코드 검증 — `POST /v1/auth/verify-code`
- [x] 회원가입 — `POST /v1/auth/register` (role: GUARDIAN)
- [x] 가입 후 자동 로그인 — `POST /v1/auth/login`
- [x] 가입 완료 후 홈 이동 — `/guardian/home`

### 로그인 (`login_page.dart`)
- [x] 로그인 — `POST /v1/auth/login`
- [x] 역할별 홈 분기 — `user.role` 기반
- [x] 로그인 후 FCM 토큰 전송 — `PATCH /v1/users/device-token`

### 스플래시 (`splash_page.dart`)
- [x] 토큰 유무 확인 → 자동 분기
- [x] 역할별 홈 분기 — TokenStorage role 기반

### 당사자 홈 (`user_home_page.dart`)
- [x] 안부 확인 버튼 (체크인) — `POST /v1/check-ins`
- [x] 마지막 안부 시각 표시 — `GET /v1/check-ins/latest`
- [x] 보호자 연결 상태 카운트 — `GET /v1/connections`

### 보호자 홈 (`guardian_home_page.dart`)
- [x] 연결된 당사자 목록 + 안부 상태 표시 — `GET /v1/connections`
- [x] 당사자별 마지막 안부 시각
- [x] 긴급 알림 (48시간 미확인) — `isTodayChecked`

### 보호자 관리 — 당사자용 (`guardian_management_page.dart`)
- [x] 보호자 목록 조회 — `GET /v1/connections`
- [x] 보호자 추가 (전화번호) — `POST /v1/connections`
- [x] 보호자 별칭 수정 — `PATCH /v1/connections/{id}/name`

### 당사자 관리 — 보호자용 (`user_management_page.dart`)
- [x] 연결된 당사자 목록 — `GET /v1/connections`
- [x] 대기 중인 초대 목록 — status: PENDING 필터링
- [x] 호칭 편집 — `PATCH /v1/connections/{id}/name`

### 설정 (`settings_action_sheet.dart`)
- [x] 로그아웃 — `POST /v1/auth/logout`
- [x] 역할 전환 — 로컬 라우팅

### FCM 토큰 (백그라운드)
- [x] 로그인/앱 시작 시 토큰 전송 — `PATCH /v1/users/device-token`
- [x] 토큰 갱신 시 서버 업데이트 — `onTokenRefresh` 리스너

### 공통 개선
- [x] 토큰 자동 갱신 인터셉터 — 401 → refresh → 재요청
- [x] API 에러 공통 처리 — `AppError.from()` + `AppErrorType`
- [x] splash role 기반 홈 분기

---

## App Store 심사 준비

### A. 심사 거절 직결 항목 (반드시 해야 함)

#### A-1. 회원 탈퇴 기능 구현
- [x] 백엔드: 회원 탈퇴 API 추가 요청 (`DELETE /v1/users/me`)
- [x] 클라이언트: `user` feature 추가
  - [x] `user/domain/repository/user_repository.dart` (interface)
  - [x] `user/domain/use_case/delete_account_use_case.dart`
  - [x] `user/data/api/user_api.dart` (Retrofit)
  - [x] `user/data/datasource/user_remote_datasource.dart`
  - [x] `user/data/repository/user_repository_impl.dart`
- [x] `setting_page.dart` `_onDeleteAccount()` 수정
  - [x] `DeleteAccountUseCase` 호출 → 토큰 삭제 → `/login` 이동
  - [x] 확인 다이얼로그 문구 강화
- [x] 단위 테스트 추가

#### A-2. 개인정보 처리방침 (Privacy Policy)
- [x] 개인정보 처리방침 작성 (수집 항목, 이용 목적, 보관 기간, 제3자 제공)
- [x] 호스팅 (GitHub Pages) — https://jineunpark.github.io/duty-checker-client/privacy_docs/privacy-policy.html
- [ ] App Store Connect에 Privacy Policy URL 입력
- [x] 앱 내 설정 화면에 "개인정보 처리방침" 메뉴 추가

#### A-3. 이용약관 (Terms of Service)
- [x] 이용약관 작성 및 호스팅 — https://jineunpark.github.io/duty-checker-client/privacy_docs/terms-of-service.html
- [x] 설정 화면에 "이용약관" 메뉴 추가

#### A-4. PrivacyInfo.xcprivacy 파일 작성 (iOS 17+)
- [x] `ios/Runner/PrivacyInfo.xcprivacy` 생성
  - [x] NSPrivacyTracking: false
  - [x] NSPrivacyCollectedDataTypes 선언 (Phone Number, Device ID, Other User Content)
  - [x] NSPrivacyAccessedAPITypes 선언 (UserDefaults — CA92.1)
- [x] Xcode 프로젝트에 파일 등록 (Copy Bundle Resources)

#### A-5. App Store Connect 메타데이터
- [ ] 앱 이름: "오늘안부" / "Duty Checker"
- [ ] 부제목 (30자)
- [ ] 카테고리: Health & Fitness 또는 Lifestyle
- [ ] 키워드 (100자, 쉼표 구분)
- [ ] 앱 설명 (한글/영문, 4000자 이내)
- [ ] 프로모션 텍스트 (170자)
- [ ] 연령 등급 설문 (4+)
- [ ] 지원 URL
- [ ] 저작권 표기

#### A-6. 스크린샷
- [ ] 6.9" iPhone 17 Pro Max — 최소 3장 (1290 x 2796 px)
- [ ] 6.5" iPhone 11 Pro Max — 필요 시
- [ ] 5.5" iPhone 8 Plus — 필요 시
- [ ] 권장 화면: 스플래시, 회원가입, 당사자 홈, 보호자 홈, 보호자 관리

---

### B. 권한 / 설정 (빌드 거부 방지)

#### B-1. Info.plist 권한 사용 설명
- [ ] NSUserNotificationsUsageDescription 추가 (FCM 푸시 알림)
- [ ] image_picker 사용 여부 확인 → 미사용 시 의존성 제거
- [x] `tel`, `sms` URL Scheme — LSApplicationQueriesSchemes 등록 완료

#### B-2. 푸시 알림 권한 요청 시점 개선
- [ ] 권한 요청 시점을 로그인 직후 또는 온보딩으로 변경
- [ ] 권한 거부 시 안내 메시지

#### B-3. 푸시 알림 메시지 카테고리 / 액션 (선택)
- [ ] 안부 미확인 알림 메시지 포맷 정의
- [ ] 알림 탭 시 딥링크

---

### C. 빌드 / 배포 설정

#### C-1. 버전 관리
- [ ] `pubspec.yaml` version 정책 정립
- [ ] CHANGELOG 작성 (선택)

#### C-2. Bundle ID & 서명
- [x] Bundle ID: `com.couper.dutyChecker`
- [x] DEVELOPMENT_TEAM: `RZRDYS2RA7`
- [ ] App Store Connect에 앱 등록
- [ ] Distribution Certificate 발급
- [ ] App Store Provisioning Profile 생성
- [ ] Xcode Signing & Capabilities 설정

#### C-3. Capabilities 설정 확인
- [x] Push Notifications 활성화
- [x] Background Modes → Remote notifications
- [ ] Xcode에서 Apple Developer Portal 동기화 확인

#### C-4. 런치 스크린
- [ ] 현재 LaunchImage.imageset이 플레이스홀더 → 실제 이미지 교체
- [ ] LaunchScreen.storyboard에 앱 로고/색상 반영

#### C-5. 앱 아이콘
- [x] AppIcon.appiconset 모든 크기 등록 완료
- [ ] 1024x1024 마케팅 아이콘 alpha 채널 없는지 확인
- [ ] 아이콘 최종 디자인 확인

---

### D. UX 개선 (심사 통과 후 권장)

#### D-1. 이미 체크인한 상태 UX 개선
- [ ] `todayChecked == true`일 때 버튼 비활성화 또는 다른 색상
- [ ] "오늘은 이미 안부를 전달했어요" 안내 표시
- [ ] 다음 체크인 가능 시각 안내

#### D-2. 네트워크 에러 / 로딩 UX
- [ ] 모든 화면 로딩 인디케이터 일관성 점검
- [ ] 네트워크 오프라인 감지 및 안내
- [ ] Retry 버튼 제공

#### D-3. 빈 상태 일러스트
- [x] 보호자 홈 (연결된 당사자 없음) — 구현됨
- [ ] 당사자 홈 (보호자 없음) — 안내 추가
- [ ] 보호자 관리 화면 (목록 비었을 때)

#### D-4. 당사자 관리 — 보호자가 당사자 등록 (`user_management_page.dart`)
- [x] 당사자 추가 UI 구현 (전화번호 입력 + 추가 버튼)
  - [x] 전화번호 입력 필드 (010-XXXX-XXXX 자동 포매팅)
  - [x] 추가 버튼 — `POST /v1/connections` API 호출 (`addConnection`)
  - [x] 추가 성공/실패 토스트 메시지
- [x] 빈 상태 일러스트 (연결된 당사자 없을 때)
- [ ] 백엔드 API 수정 후 DTO 연동 — [#10](https://github.com/JinEunPark/duty-checker-client/issues/10)

#### D-4.1. 연결 수락/거절 UI
- [x] `user_management_page.dart` (보호자용) — 대기 중 카드에 수락/거절 버튼 추가
- [x] `guardian_management_page.dart` (당사자용) — 대기 중 카드에 수락/거절 버튼 추가, 섹션 분리
- [x] 백엔드 수락/거절/삭제 API 연동 — [#11](https://github.com/JinEunPark/duty-checker-client/issues/11)

#### D-5. 푸시 알림 권한 거부 시 처리
- [ ] 권한 거부 상태에서도 앱 사용 가능하도록 안내
- [ ] 설정 화면에서 알림 권한 상태 표시 + iOS 설정 이동 버튼

#### D-7. 푸시 알림 실제 수신 확인
- [ ] 안부 미확인 알림 (보호자) — 실기기에서 수신 확인
- [ ] 포그라운드 상태에서 알림 수신 확인
- [ ] 백그라운드 상태에서 알림 수신 확인
- [ ] 앱 종료 상태에서 알림 수신 확인
- [ ] 알림 탭 시 앱 진입 동작 확인
- [ ] FCM 토큰 갱신 후에도 알림 정상 수신 확인

---

### E. 백엔드 API 대기 후 구현

#### E-1. 연결 요청 방향 구분 — [duty-checker#76](https://github.com/JinEunPark/duty-checker/issues/76)
- [x] 백엔드: `ConnectionItemDto`에 `requesterRole` 필드 추가 (SUBJECT/GUARDIAN enum)
- [x] 클라이언트: `ConnectionRespModel` / `Connection` 엔티티에 `requesterRole` 필드 추가
- [x] `PendingConnectionCard`에서 `requesterRole`로 분기 (내 역할 == requesterRole → showActions: false)
- [x] 내가 보낸 요청 → "수락 대기 중" 표시만, 상대가 보낸 요청 → 수락/거절 버튼
- [x] 단위 테스트 추가

#### E-2. 비밀번호 재설정 — [duty-checker#77](https://github.com/JinEunPark/duty-checker/issues/77)
- [x] 백엔드: `PATCH /v1/auth/password` API 사용 (실제 스펙 기준)
- [x] `reset_password_req_model.dart` — `{ phone, newPassword }`
- [x] `auth_api.dart`에 `@PATCH('/v1/auth/password')` 추가
- [x] `auth_remote_datasource.dart` / `auth_repository.dart` / `auth_repository_impl.dart`에 `resetPassword()` 추가
- [x] `ResetPasswordUseCase` + provider
- [x] `ResetPasswordState` (freezed) — 단계별 상태 관리
- [x] `ResetPasswordViewModel` — checkPhone → sendCode → verifyCode → resetPassword
- [x] `reset_password_page.dart` — UI 구현
- [x] `go_router`에 `/reset-password` 경로 추가
- [x] 로그인 화면에 "비밀번호를 잊으셨나요?" 링크 추가
- [x] 단위 테스트 추가

---

### F. Firebase App Distribution (테스트 배포)

- [x] Firebase 프로젝트에 App Distribution 활성화
- [x] Distribution Certificate + Ad Hoc Provisioning Profile 생성
- [x] iOS 테스트 빌드 (`flutter build ipa --release --export-method ad-hoc`)
- [x] Firebase CLI로 배포 (`firebase appdistribution:distribute`)
- [x] 테스터 그룹 생성 (`testers`)
- [ ] 테스터 실기기 설치 및 전체 플로우 검증
  - [ ] 회원가입 (당사자/보호자)
  - [ ] 로그인 / 자동 로그인
  - [ ] 안부 체크인
  - [ ] 보호자 연결 / 당사자 연결
  - [ ] 푸시 알림 수신
- [ ] 피드백 수집 후 수정 반영

---

### G. 심사 제출 직전 체크리스트

#### G-1. 빌드
- [ ] `flutter build ipa --release` 성공
- [ ] `flutter analyze` 클린
- [ ] `flutter test` 전체 통과

#### G-2. TestFlight 내부 테스트
- [ ] App Store Connect → TestFlight 업로드
- [ ] 내부 테스터 실기기 테스트
- [ ] 회원가입/로그인/체크인/보호자 연결 전체 플로우 검증
- [ ] 푸시 알림 수신 검증

#### G-3. 심사 정보 (App Review Information)
- [ ] 테스트 계정 제공 (SMS 인증 우회 방법 또는 데모 계정)
- [ ] 연락처 정보 (이름, 전화, 이메일)
- [ ] 앱 목적/시나리오 설명 (영문)

#### G-4. 광고 식별자 (IDFA)
- [ ] "이 앱은 IDFA를 사용하는가?" → 아니요 선택

#### G-5. 수출 규정 (Export Compliance)
- [ ] HTTPS 표준 암호화 → 표준 면제 선택

---

## 우선순위 요약

### 완료
- [x] 회원 탈퇴 기능 구현 (A-1)
- [x] 개인정보 처리방침 / 이용약관 작성 및 호스팅 (A-2, A-3)
- [x] PrivacyInfo.xcprivacy (A-4)
- [x] 연결 수락/거절/삭제 API 연동 (D-4.1)
- [x] `check-phone` API 연동 (회원가입 시 중복 번호 검사)

### 심사 전 필수
1. [ ] App Store Connect에 Privacy Policy URL 입력 (A-2)
2. [ ] App Store Connect 메타데이터 입력 (A-5)
3. [ ] 스크린샷 제작 (A-6)
4. [ ] 테스트 계정 제공 또는 SMS 인증 우회 방법 (G-3)
5. [ ] Info.plist 권한 설명 추가 (B-1)

### 빌드/배포에 필요
6. [ ] App Store Connect 앱 등록 + 서명 설정 (C-2)
7. [ ] 런치 스크린 실제 이미지 교체 (C-4)
8. [ ] 마케팅 아이콘 alpha 채널 확인 (C-5)

### 완료 (추가)
9. [x] 연결 요청 방향 구분 — requesterRole 필드 (E-1, [duty-checker#76](https://github.com/JinEunPark/duty-checker/issues/76))

### 백엔드 API 대기 후 구현
10. [ ] 비밀번호 재설정 기능 (E-2, [duty-checker#77](https://github.com/JinEunPark/duty-checker/issues/77))

### 권장 (심사 통과 후 개선)
11. [ ] 이미 체크인 상태 UX 개선 (D-1)
12. [ ] 푸시 권한 요청 시점 개선 (B-2)
13. [ ] 네트워크 에러 / 빈 상태 UI (D-2, D-3)

---

## 참고
- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [한국어 번역](https://developer.apple.com/kr/app-store/review/guidelines/)
- [Privacy Manifest 가이드](https://developer.apple.com/documentation/bundleresources/privacy_manifest_files)
