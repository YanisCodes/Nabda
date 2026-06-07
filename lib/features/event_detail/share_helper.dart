import 'package:intl/intl.dart' as intl;

import '../../data/models/center.dart' as model;
import '../../data/models/event.dart';

/// Builds a plain-text share payload from an [event] and optional [center].
String buildShareText(
  Event event, {
  model.Center? center,
  String appName = 'OTEJ Link',
}) {
  final date = _formatDateRange(event);
  final location = center?.name ?? event.city;

  final buffer = StringBuffer()
    ..writeln(event.title)
    ..writeln()
    ..writeln('📍 $location')
    ..writeln('📅 $date');

  if (center?.phone != null) {
    buffer.writeln('📞 ${center!.phone}');
  }

  buffer.writeln();
  buffer.write(appName);

  return buffer.toString();
}

String _formatDateRange(Event e) {
  final start = _fmt(e.dateStart);
  if (e.dateEnd == null) return start;
  final end = _fmt(e.dateEnd!);
  if (start == end) {
    return '$start · ${_time(e.dateStart)} – ${_time(e.dateEnd!)}';
  }
  return '$start – $end';
}

String _fmt(DateTime d) => intl.DateFormat.yMMMd('fr').format(d);

String _time(DateTime d) => '${d.hour}h${d.minute.toString().padLeft(2, '0')}';
