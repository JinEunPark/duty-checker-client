/// 서버에서 받은 ISO-8601 시각 문자열을 로컬 DateTime으로 파싱한다.
///
/// 서버가 timezone 표기(`Z` 또는 `±HH:MM`) 없이 UTC 시각을 보내는 경우
/// `DateTime.parse`는 이를 로컬 시각으로 잘못 해석한다.
/// 이 함수는 timezone 표기가 없으면 UTC로 간주하고, 마지막에 항상
/// `toLocal()`로 변환하여 일관된 로컬 시각을 반환한다.
DateTime? parseServerDateTime(String? iso) {
  if (iso == null || iso.isEmpty) return null;
  final hasTimezone =
      iso.endsWith('Z') || RegExp(r'[+-]\d{2}:?\d{2}$').hasMatch(iso);
  final normalized = hasTimezone ? iso : '${iso}Z';
  return DateTime.tryParse(normalized)?.toLocal();
}

extension DateTimeFormatting on DateTime {
  String formatRelative() {
    final local = isUtc ? toLocal() : this;
    final now = DateTime.now();
    final diff = now.difference(local);
    final minutes = diff.inMinutes;

    if (minutes < 1) return '방금 전';
    if (minutes < 60) return '$minutes분 전';

    final isToday = local.year == now.year &&
        local.month == now.month &&
        local.day == now.day;

    final period = local.hour < 12 ? '오전' : '오후';
    final h = local.hour % 12 == 0 ? 12 : local.hour % 12;
    final m = local.minute.toString().padLeft(2, '0');
    final timeStr = '$period $h:$m';

    if (isToday) return '오늘 $timeStr';

    final yesterday = now.subtract(const Duration(days: 1));
    final isYesterday = local.year == yesterday.year &&
        local.month == yesterday.month &&
        local.day == yesterday.day;

    if (isYesterday) return '어제 $timeStr';
    return '${local.month}월 ${local.day}일 $timeStr';
  }
}
