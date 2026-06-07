import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/preferences.dart';
import '../../data/models/event.dart';
import 'notification_helper.dart';

enum ReminderResult { set, removed, tooLate, permissionDenied }

final reminderProvider = NotifierProvider<ReminderNotifier, Set<String>>(
  ReminderNotifier.new,
);

class ReminderNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => ref.read(preferencesProvider).reminderIds;

  Future<ReminderResult> toggleReminder(Event event) async {
    final prefs = ref.read(preferencesProvider);
    final updated = Set<String>.from(state);

    if (updated.contains(event.id)) {
      await cancelEventReminder(event.id);
      updated.remove(event.id);
      await prefs.setReminderIds(updated);
      state = updated;
      return ReminderResult.removed;
    }

    final granted = await requestNotificationPermission();
    if (!granted) return ReminderResult.permissionDenied;

    final scheduled = await scheduleEventReminder(event);
    if (!scheduled) return ReminderResult.tooLate;

    updated.add(event.id);
    await prefs.setReminderIds(updated);
    state = updated;
    return ReminderResult.set;
  }
}
