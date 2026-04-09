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
| 가입 후 로그인 화면 이동 | — | ✅ 변경됨 — 회원가입 완료 후 `/login`으로 이동 |
| 보호자 전화번호 추가 | `POST /v1/connections` | ❌ 미구현 — 스텝4 보호자 추가가 로컬 `List<String>`만 사용 중, API 저장 안 됨 |

**필요한 feature**: auth (✅ 완료), connection (✅ 완료 — 회원가입 화면 연결만 필요)

---

## 2. 보호자 회원가입 (`guardian_sign_up_page.dart`)

| 기능 | API | 상태 |
|------|-----|------|
| 전화번호 인증코드 발송 | `POST /v1/auth/send-code` | ✅ 연결됨 |
| 인증코드 검증 | `POST /v1/auth/verify-code` | ✅ 연결됨 |
| 회원가입 | `POST /v1/auth/register` (role: GUARDIAN) | ✅ 연결됨 |
| 가입 후 로그인 화면 이동 | — | ✅ 변경됨 — 회원가입 완료 후 `/login`으로 이동 |

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
| 로그아웃 | `POST /v1/auth/logout` | ❌ 미흡 — `tokenStorage.clear()`만 호출, `LogoutUseCase`(서버 로그아웃) 미사용 |
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

1. **회원가입 보호자 추가 API 연결** — 스텝4에서 `POST /v1/connections` 호출
2. **설정 로그아웃 개선** — `LogoutUseCase` 연결 (서버 로그아웃 + 토큰 삭제)
3. ~~**토큰 자동 갱신 인터셉터**~~ ✅ 완료 — `AuthInterceptor.onError`에서 401 감지 → refresh → 재요청
