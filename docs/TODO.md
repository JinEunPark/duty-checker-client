# API 연동 TODO (화면 기능 단위)

## 인프라 (완료)
- [x] `core/network/` — Dio provider, AuthInterceptor, TokenStorage
- [x] `auth/` — domain + data 레이어 전체 (Entity, Repository, UseCase, DTO, API, DataSource)

---

## 1. 당사자 회원가입 (`self_sign_up_page.dart`)

| 기능 | API | 상태 |
|------|-----|------|
| 전화번호 인증코드 발송 | `POST /v1/auth/send-code` | ✅ 연결됨 |
| 인증코드 검증 | `POST /v1/auth/verify-code` | ✅ 연결됨 |
| 회원가입 | `POST /v1/auth/register` (role: SUBJECT) | ✅ 연결됨 |
| 가입 후 자동 로그인 | `POST /v1/auth/login` | ❌ 미구현 — 가입 완료 후 login API 호출 → 토큰 저장 → 홈 이동 필요 |
| 보호자 전화번호 추가 | `POST /v1/connections` | ❌ 미구현 — 스텝4 보호자 추가가 로컬 리스트만 사용 중 |

**필요한 feature**: auth (기존), connection (신규)

---

## 2. 보호자 회원가입 (`guardian_sign_up_page.dart`)

| 기능 | API | 상태 |
|------|-----|------|
| 전화번호 인증코드 발송 | `POST /v1/auth/send-code` | ✅ 연결됨 |
| 인증코드 검증 | `POST /v1/auth/verify-code` | ✅ 연결됨 |
| 회원가입 | `POST /v1/auth/register` (role: GUARDIAN) | ✅ 연결됨 |
| 가입 후 자동 로그인 | `POST /v1/auth/login` | ❌ 미구현 — 가입 완료 후 login API 호출 → 토큰 저장 → 홈 이동 필요 |

**필요한 feature**: auth (기존)

---

## 3. 로그인 (`login_page.dart`)

| 기능 | API | 상태 |
|------|-----|------|
| 로그인 | `POST /v1/auth/login` | ✅ 연결됨 |
| 역할별 홈 분기 | 응답의 `user.role` 기반 | ✅ 연결됨 |
| 로그인 후 FCM 토큰 전송 | `PATCH /v1/users/device-token` | ❌ 미구현 |

**필요한 feature**: auth (기존), user (신규)

---

## 4. 스플래시 (`splash_page.dart`)

| 기능 | API | 상태 |
|------|-----|------|
| 토큰 유무 확인 → 자동 분기 | 없음 (로컬 토큰 확인) | ✅ 연결됨 |
| 역할별 홈 분기 | 저장된 role 기반 | ❌ 미구현 — 현재 토큰 있으면 무조건 `/user/home`으로 이동. role 저장 후 분기 필요 |

**필요한 작업**: TokenStorage에 role 저장 추가, splash에서 role 기반 분기

---

## 5. 당사자 홈 (`user_home_page.dart`)

| 기능 | API | 상태 |
|------|-----|------|
| 안부 확인 버튼 (체크인) | `POST /v1/check-ins` | ❌ 더미 — `_onCheckIn()`이 로컬 상태만 변경 |
| 마지막 안부 시각 표시 | `GET /v1/check-ins/latest` | ❌ 더미 — `_lastCheckTime`이 로컬 변수 |
| 보호자 연결 상태 카운트 | `GET /v1/connections` | ❌ 더미 — `_pendingGuardians`, `_activeGuardians`가 하드코딩 |

**필요한 feature**: check_in (신규), connection (신규)

---

## 6. 보호자 홈 (`guardian_home_page.dart`)

| 기능 | API | 상태 |
|------|-----|------|
| 연결된 당사자 목록 + 안부 상태 표시 | `GET /v1/connections` | ❌ 더미 — `_connectedUsers` 하드코딩 리스트 |
| 당사자별 마지막 안부 시각 | `GET /v1/connections`의 `latestCheckedAt` | ❌ 더미 |
| 긴급 알림 (48시간 미확인) | `GET /v1/connections`의 `isTodayChecked` | ❌ 더미 |

**필요한 feature**: connection (신규)

---

## 7. 보호자 관리 — 당사자용 (`guardian_management_page.dart`)

| 기능 | API | 상태 |
|------|-----|------|
| 보호자 목록 조회 | `GET /v1/connections` | ❌ 더미 — `_guardians` 하드코딩 리스트 |
| 보호자 추가 (전화번호) | `POST /v1/connections` | ❌ 더미 — 로컬 리스트에 추가만 |
| 보호자 별칭 수정 | `PATCH /v1/connections/{id}/name` | ❌ 더미 — 로컬 상태만 변경 |

**필요한 feature**: connection (신규)

---

## 8. 당사자 관리 — 보호자용 (`user_management_page.dart`)

| 기능 | API | 상태 |
|------|-----|------|
| 연결된 당사자 목록 | `GET /v1/connections` | ❌ 더미 — `_connectedUsers` 하드코딩 리스트 |
| 대기 중인 초대 목록 | `GET /v1/connections` (status: PENDING) | ❌ 더미 — `_invitations` 하드코딩 리스트 |
| 호칭 편집 | `PATCH /v1/connections/{id}/name` | ❌ 더미 — 로컬 상태만 변경 |

**필요한 feature**: connection (신규)

---

## 9. 설정 (`settings_action_sheet.dart`)

| 기능 | API | 상태 |
|------|-----|------|
| 로그아웃 | `POST /v1/auth/logout` | ❌ 미구현 — `context.go('/login')`만 호출, 토큰 삭제/서버 로그아웃 없음 |
| 역할 전환 | 없음 (로컬 라우팅) | ✅ 동작함 |

**필요한 feature**: auth (기존 LogoutUseCase 연결만)

---

## 10. FCM 토큰 (백그라운드)

| 기능 | API | 상태 |
|------|-----|------|
| 로그인/앱 시작 시 토큰 전송 | `PATCH /v1/users/device-token` | ❌ 미구현 |
| 토큰 갱신 시 서버 업데이트 | `PATCH /v1/users/device-token` | ❌ 미구현 |

**필요한 feature**: user (신규)

---

## 신규 feature 구현 필요 목록

### connection feature (7개 화면에서 사용)
- 사용 API: `GET /v1/connections`, `POST /v1/connections`, `PATCH /v1/connections/{id}/name`
- 사용 화면: 당사자 회원가입, 당사자 홈, 보호자 홈, 보호자 관리, 당사자 관리

### check_in feature (1개 화면에서 사용)
- 사용 API: `POST /v1/check-ins`, `GET /v1/check-ins/latest`
- 사용 화면: 당사자 홈

### user feature (백그라운드)
- 사용 API: `PATCH /v1/users/device-token`
- 사용 위치: 로그인 성공 후, FCM 토큰 갱신 시

---

## 공통 개선
- [ ] 토큰 자동 갱신 인터셉터 (401 → `POST /v1/auth/refresh` → 재요청)
- [ ] API 에러 공통 처리 (`core/error/`)
- [ ] splash에서 role 기반 홈 분기

---

## 권장 작업 순서

1. **보호자 회원가입 완성** — 자동 로그인 연결 (auth 기존 UseCase 활용)
2. **당사자 회원가입 완성** — 자동 로그인 + connection 추가
3. **connection feature 구현** → 보호자 관리, 당사자 관리, 양쪽 홈 연결
4. **check_in feature 구현** → 당사자 홈 연결
5. **설정 로그아웃 연결** (auth 기존 LogoutUseCase 활용)
6. **user feature 구현** → FCM 토큰 전송
7. **공통 개선** — 토큰 갱신, 에러 처리, splash 분기
