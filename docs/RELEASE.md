# 배포 가이드 — 오늘안부 (duty_checker)

## 버전 규칙

`pubspec.yaml`의 `version` 필드: `MAJOR.MINOR.PATCH+BUILD`

| 구분 | 올리는 시점 | 예시 |
|------|-----------|------|
| **MAJOR** | 호환되지 않는 큰 변경 (전면 리뉴얼, 파괴적 API 변경) | `1.0.0` → `2.0.0` |
| **MINOR** | 새로운 기능 추가 | `1.0.3` → `1.1.0` |
| **PATCH** | 버그 수정, 소소한 개선 | `1.0.3` → `1.0.4` |
| **BUILD** | 매 배포마다 1씩 증가 (리셋하지 않음) | `+5` → `+6` |

### 규칙 요약

- BUILD 번호는 버전과 무관하게 **항상 1씩 증가**한다 (Apple/Google 스토어 정책).
- 배포 전 반드시 사용자에게 **현재 버전**과 **변경할 버전**을 보고하고 확인받는다.

## 배포 절차

### iOS — Firebase App Distribution

```bash
# 1. pubspec.yaml 버전 변경
# version: X.Y.Z+N

# 2. iOS 빌드 (archive)
flutter build ipa --release --no-codesign

# 3. IPA export (ad-hoc 서명)
xcodebuild -exportArchive \
  -archivePath build/ios/archive/Runner.xcarchive \
  -exportOptionsPlist ios/ExportOptions.plist \
  -exportPath build/ios/ipa

# 4. Firebase 배포
firebase appdistribution:distribute build/ios/ipa/duty_checker.ipa \
  --app 1:578770307794:ios:317adeb359f53858ed7b0b \
  --release-notes "vX.Y.Z 배포"
```

### Android — Firebase App Distribution

```bash
# 1. pubspec.yaml 버전 변경 (iOS와 동일)

# 2. APK 빌드
flutter build apk --release

# 3. Firebase 배포
firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk \
  --app 1:578770307794:android:78eb2cc434e229f3ed7b0b \
  --release-notes "vX.Y.Z 배포"
```

## 배포 전 체크리스트

- [ ] `flutter analyze` 통과
- [ ] `flutter test` 통과
- [ ] `pubspec.yaml` 버전 및 빌드 번호 업데이트
- [ ] 릴리스 노트 작성
- [ ] 배포 후 Firebase 콘솔에서 업로드 확인

## 배포 이력

| 날짜 | 버전 | 플랫폼 | 비고 |
|------|------|--------|------|
| 2026-04-18 | 1.0.3+5 | iOS | Firebase App Distribution |
| 2026-04-18 | 1.0.3+5 | Android | Firebase App Distribution — ConnectionStatus rejected 추가, AGP/Kotlin 업데이트 |
| 2026-04-18 | 1.0.4+6 | iOS | Firebase App Distribution |
| 2026-05-05 | 1.0.5+8 | iOS | Firebase App Distribution — FCM 토큰 서버 전송 버그 수정 |
| 2026-05-05 | 1.0.5+8 | Android | Firebase App Distribution — FCM 토큰 서버 전송 버그 수정 |
