import 'package:duty_checker/core/widget/connection_widgets.dart';
import 'package:duty_checker/connection/domain/entity/connection.dart';
import 'package:duty_checker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

/// 테스트용 앱 래퍼 (AppThemeScope + CupertinoApp)
Widget _testApp(Widget child) {
  return AppThemeScope(
    isDark: false,
    child: CupertinoApp(
      home: CupertinoPageScaffold(
        child: SingleChildScrollView(child: child),
      ),
    ),
  );
}

// ─────────────────────────────────────────────
// ToastMixin 테스트용 위젯
// ─────────────────────────────────────────────
class _ToastTestWidget extends StatefulWidget {
  const _ToastTestWidget();

  @override
  State<_ToastTestWidget> createState() => _ToastTestWidgetState();
}

class _ToastTestWidgetState extends State<_ToastTestWidget> with ToastMixin {
  @override
  Widget build(BuildContext context) {
    return AppThemeScope(
      isDark: false,
      child: CupertinoApp(
        home: CupertinoPageScaffold(
          child: Column(
            children: [
              CupertinoButton(
                key: const Key('toast1'),
                onPressed: () => showToast('메시지1'),
                child: const Text('버튼1'),
              ),
              CupertinoButton(
                key: const Key('toast2'),
                onPressed: () => showToast('메시지2'),
                child: const Text('버튼2'),
              ),
              if (toastMessage != null)
                Text(toastMessage!, key: const Key('msg')),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  group('ToastMixin', () {
    testWidgets('showToast 호출 시 메시지가 표시된다', (tester) async {
      await tester.pumpWidget(const _ToastTestWidget());

      await tester.tap(find.byKey(const Key('toast1')));
      await tester.pump();

      expect(find.byKey(const Key('msg')), findsOneWidget);
      expect(find.text('메시지1'), findsOneWidget);
    });

    testWidgets('3초 후 토스트 메시지가 사라진다', (tester) async {
      await tester.pumpWidget(const _ToastTestWidget());

      await tester.tap(find.byKey(const Key('toast1')));
      await tester.pump();
      expect(find.byKey(const Key('msg')), findsOneWidget);

      await tester.pump(const Duration(seconds: 3));
      expect(find.byKey(const Key('msg')), findsNothing);
    });

    testWidgets('연속 호출 시 이전 타이머가 취소되고 새 메시지가 표시된다',
        (tester) async {
      await tester.pumpWidget(const _ToastTestWidget());

      // 첫 번째 토스트
      await tester.tap(find.byKey(const Key('toast1')));
      await tester.pump();
      expect(find.text('메시지1'), findsOneWidget);

      // 1초 후 두 번째 토스트
      await tester.pump(const Duration(seconds: 1));
      await tester.tap(find.byKey(const Key('toast2')));
      await tester.pump();

      // 새 메시지로 교체됨
      expect(find.text('메시지2'), findsOneWidget);
      expect(find.text('메시지1'), findsNothing);

      // 첫 번째 타이머의 만료 시점(2초 더) — 아직 두 번째 토스트 표시 중
      await tester.pump(const Duration(seconds: 2));
      expect(find.byKey(const Key('msg')), findsOneWidget);

      // 두 번째 타이머 만료 (1초 더)
      await tester.pump(const Duration(seconds: 1));
      expect(find.byKey(const Key('msg')), findsNothing);
    });
  });

  group('showDestructiveConfirmDialog', () {
    testWidgets('취소 버튼 누르면 false를 반환한다', (tester) async {
      bool? result;

      await tester.pumpWidget(
        AppThemeScope(
          isDark: false,
          child: CupertinoApp(
            home: Builder(
              builder: (context) => CupertinoPageScaffold(
                child: CupertinoButton(
                  key: const Key('open'),
                  onPressed: () async {
                    result = await showDestructiveConfirmDialog(
                      context,
                      title: '삭제 확인',
                      content: '정말 삭제하시겠습니까?',
                    );
                  },
                  child: const Text('열기'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('open')));
      await tester.pumpAndSettle();

      expect(find.text('삭제 확인'), findsOneWidget);
      expect(find.text('정말 삭제하시겠습니까?'), findsOneWidget);

      await tester.tap(find.text('취소'));
      await tester.pumpAndSettle();

      expect(result, isFalse);
    });

    testWidgets('삭제 버튼 누르면 true를 반환한다', (tester) async {
      bool? result;

      await tester.pumpWidget(
        AppThemeScope(
          isDark: false,
          child: CupertinoApp(
            home: Builder(
              builder: (context) => CupertinoPageScaffold(
                child: CupertinoButton(
                  key: const Key('open'),
                  onPressed: () async {
                    result = await showDestructiveConfirmDialog(
                      context,
                      title: '삭제 확인',
                      content: '정말 삭제하시겠습니까?',
                    );
                  },
                  child: const Text('열기'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('open')));
      await tester.pumpAndSettle();

      await tester.tap(find.text('삭제'));
      await tester.pumpAndSettle();

      expect(result, isTrue);
    });

    testWidgets('커스텀 destructiveLabel이 표시된다', (tester) async {
      await tester.pumpWidget(
        AppThemeScope(
          isDark: false,
          child: CupertinoApp(
            home: Builder(
              builder: (context) => CupertinoPageScaffold(
                child: CupertinoButton(
                  key: const Key('open'),
                  onPressed: () => showDestructiveConfirmDialog(
                    context,
                    title: '거절',
                    content: '거절하시겠습니까?',
                    destructiveLabel: '거절하기',
                  ),
                  child: const Text('열기'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('open')));
      await tester.pumpAndSettle();

      expect(find.text('거절하기'), findsOneWidget);
    });
  });

  group('ConnectionSectionHeader', () {
    testWidgets('제목과 카운트가 올바르게 표시된다', (tester) async {
      await tester.pumpWidget(
        _testApp(const ConnectionSectionHeader(title: '연결된 분', count: 3)),
      );

      expect(find.text('연결된 분 (3)'), findsOneWidget);
    });
  });

  group('ConnectionEmptyState', () {
    testWidgets('제목과 부제가 올바르게 표시된다', (tester) async {
      await tester.pumpWidget(
        _testApp(const ConnectionEmptyState(
          title: '아직 없어요',
          subtitle: '등록해 보세요',
        )),
      );

      expect(find.text('아직 없어요'), findsOneWidget);
      expect(find.text('등록해 보세요'), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.person_2_fill), findsOneWidget);
    });
  });

  group('PendingConnectionCard', () {
    final connection = Connection(
      id: 1,
      phone: '01012345678',
      name: '테스트',
      status: ConnectionStatus.pending,
      latestCheckedAt: null,
      isTodayChecked: false,
    );

    testWidgets('이름과 전화번호가 표시된다', (tester) async {
      await tester.pumpWidget(
        _testApp(PendingConnectionCard(
          connection: connection,
          onAccept: () {},
          onReject: () {},
        )),
      );

      expect(find.text('테스트'), findsOneWidget);
      expect(find.text('01012345678'), findsOneWidget);
      expect(find.text('연결 대기 중'), findsOneWidget);
      expect(find.text('수락'), findsOneWidget);
      expect(find.text('거절'), findsOneWidget);
    });

    testWidgets('showActions가 false이면 수락/거절 버튼이 표시되지 않는다', (tester) async {
      await tester.pumpWidget(
        _testApp(PendingConnectionCard(
          connection: connection,
          showActions: false,
        )),
      );

      expect(find.text('테스트'), findsOneWidget);
      expect(find.text('연결 대기 중'), findsOneWidget);
      expect(find.text('수락'), findsNothing);
      expect(find.text('거절'), findsNothing);
    });

    testWidgets('이름이 없으면 전화번호가 대표 이름으로 표시된다', (tester) async {
      final noName = Connection(
        id: 2,
        phone: '01099998888',
        name: '',
        status: ConnectionStatus.pending,
        latestCheckedAt: null,
        isTodayChecked: false,
      );

      await tester.pumpWidget(
        _testApp(PendingConnectionCard(
          connection: noName,
          onAccept: () {},
          onReject: () {},
        )),
      );

      expect(find.text('01099998888'), findsOneWidget);
    });

    testWidgets('수락 버튼 탭 시 onAccept 콜백이 호출된다', (tester) async {
      var accepted = false;

      await tester.pumpWidget(
        _testApp(PendingConnectionCard(
          connection: connection,
          onAccept: () => accepted = true,
          onReject: () {},
        )),
      );

      await tester.tap(find.text('수락'));
      expect(accepted, isTrue);
    });

    testWidgets('거절 버튼 탭 시 onReject 콜백이 호출된다', (tester) async {
      var rejected = false;

      await tester.pumpWidget(
        _testApp(PendingConnectionCard(
          connection: connection,
          onAccept: () {},
          onReject: () => rejected = true,
        )),
      );

      await tester.tap(find.text('거절'));
      expect(rejected, isTrue);
    });
  });

  group('AddConnectionCard', () {
    testWidgets('기본 placeholder가 표시된다', (tester) async {
      final controller = TextEditingController();
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        _testApp(AddConnectionCard(
          controller: controller,
          connectionCount: 0,
          onAdd: () {},
        )),
      );

      expect(find.text('전화번호 입력'), findsOneWidget);
      expect(find.text('최대 5명까지 등록 가능 · 0/5'), findsOneWidget);
    });

    testWidgets('커스텀 placeholder가 표시된다', (tester) async {
      final controller = TextEditingController();
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        _testApp(AddConnectionCard(
          controller: controller,
          connectionCount: 1,
          onAdd: () {},
          placeholder: '당사자 전화번호 입력',
        )),
      );

      expect(find.text('당사자 전화번호 입력'), findsOneWidget);
      expect(find.text('최대 5명까지 등록 가능 · 1/5'), findsOneWidget);
    });

    testWidgets('5명 이상이면 입력 필드가 비활성화된다', (tester) async {
      final controller = TextEditingController();
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        _testApp(AddConnectionCard(
          controller: controller,
          connectionCount: 5,
          onAdd: () {},
        )),
      );

      expect(find.text('최대 5명까지 등록 가능 · 5/5'), findsOneWidget);

      final textField =
          tester.widget<CupertinoTextField>(find.byType(CupertinoTextField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('추가 버튼 탭 시 onAdd 콜백이 호출된다', (tester) async {
      var added = false;
      final controller = TextEditingController();
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        _testApp(AddConnectionCard(
          controller: controller,
          connectionCount: 0,
          onAdd: () => added = true,
        )),
      );

      await tester.tap(find.byIcon(CupertinoIcons.add));
      expect(added, isTrue);
    });
  });

  group('AppToast', () {
    testWidgets('메시지가 올바르게 표시된다', (tester) async {
      await tester.pumpWidget(
        _testApp(const AppToast(message: '저장되었습니다')),
      );

      expect(find.text('저장되었습니다'), findsOneWidget);
      expect(
          find.byIcon(CupertinoIcons.checkmark_circle_fill), findsOneWidget);
    });
  });
}
