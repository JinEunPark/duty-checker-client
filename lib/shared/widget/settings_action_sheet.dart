import 'package:duty_checker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

enum UserRole { user, guardian }

/// 설정 기어 버튼 + 드롭다운 메뉴 위젯
class SettingsDropdown extends StatefulWidget {
  const SettingsDropdown({super.key, required this.currentRole});

  final UserRole currentRole;

  @override
  State<SettingsDropdown> createState() => _SettingsDropdownState();
}

class _SettingsDropdownState extends State<SettingsDropdown> {
  final _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _toggle() {
    if (_isOpen) {
      _close();
    } else {
      _open();
    }
  }

  void _open() {
    _overlayEntry = _buildOverlay();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _close() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isOpen = false;
    if (mounted) setState(() {});
  }

  OverlayEntry _buildOverlay() {
    return OverlayEntry(
      builder: (ctx) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _close,
        child: Stack(
          children: [
            CompositedTransformFollower(
              link: _layerLink,
              targetAnchor: Alignment.bottomRight,
              followerAnchor: Alignment.topRight,
              offset: const Offset(0, 8),
              child: _DropdownMenu(
                currentRole: widget.currentRole,
                onClose: _close,
                onSwitchRole: () {
                  _close();
                  _switchRole();
                },
                onLogout: () {
                  _close();
                  _confirmLogout();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _switchRole() {
    final target = widget.currentRole == UserRole.user
        ? '/guardian/home'
        : '/user/home';
    context.go(target);
  }

  void _confirmLogout() {
    showCupertinoDialog<void>(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('로그아웃'),
        content: const Text('정말 로그아웃 하시겠습니까?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('로그아웃'),
            onPressed: () {
              Navigator.pop(ctx);
              context.go('/login');
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: _toggle,
        child: const Icon(
          CupertinoIcons.gear,
          size: 26,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _DropdownMenu extends StatelessWidget {
  const _DropdownMenu({
    required this.currentRole,
    required this.onClose,
    required this.onSwitchRole,
    required this.onLogout,
  });

  final UserRole currentRole;
  final VoidCallback onClose;
  final VoidCallback onSwitchRole;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final switchLabel = currentRole == UserRole.user
        ? '보호자로 전환'
        : '당사자로 전환';
    final switchIcon = currentRole == UserRole.user
        ? CupertinoIcons.person_2_fill
        : CupertinoIcons.person_fill;

    return Container(
      width: 170,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray900.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: AppColors.gray900.withValues(alpha: 0.04),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DropdownItem(
            icon: switchIcon,
            label: switchLabel,
            onTap: onSwitchRole,
          ),
          const _Divider(),
          _DropdownItem(
            icon: CupertinoIcons.square_arrow_right,
            label: '로그아웃',
            isDestructive: true,
            onTap: onLogout,
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(height: 0.5, color: AppColors.border),
    );
  }
}

class _DropdownItem extends StatelessWidget {
  const _DropdownItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.textPrimary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
