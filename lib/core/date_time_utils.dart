extension DateTimeFormatting on DateTime {
  String formatRelative() {
    final now = DateTime.now();
    final diff = now.difference(this);
    final minutes = diff.inMinutes;

    if (minutes < 1) return '방금 전';
    if (minutes < 60) return '$minutes분 전';

    final isToday =
        year == now.year && month == now.month && day == now.day;

    final period = hour < 12 ? '오전' : '오후';
    final h = hour % 12 == 0 ? 12 : hour % 12;
    final m = minute.toString().padLeft(2, '0');
    final timeStr = '$period $h:$m';

    if (isToday) return '오늘 $timeStr';

    final yesterday = now.subtract(const Duration(days: 1));
    final isYesterday = year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;

    if (isYesterday) return '어제 $timeStr';
    return '$month월 $day일 $timeStr';
  }
}
