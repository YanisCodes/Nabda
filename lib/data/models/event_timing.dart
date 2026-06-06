import 'event.dart';

enum EventTimingStatus { upcoming, soon, ongoing, past }

extension EventTiming on Event {
  static const _soonWindow = Duration(days: 7);

  EventTimingStatus get timingStatus {
    final now = DateTime.now();
    // Si pas de dateEnd, on estime 3h après le début
    final effectiveEnd = dateEnd ?? dateStart.add(const Duration(hours: 3));
    if (effectiveEnd.isBefore(now)) return EventTimingStatus.past;
    if (!dateStart.isAfter(now)) return EventTimingStatus.ongoing;
    if (dateStart.difference(now) <= _soonWindow) return EventTimingStatus.soon;
    return EventTimingStatus.upcoming;
  }
}
