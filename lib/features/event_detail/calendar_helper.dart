import 'package:add_2_calendar/add_2_calendar.dart' as cal;

import '../../data/models/center.dart' as model;
import '../../data/models/event.dart';

void addEventToCalendar(Event event, {model.Center? center}) {
  final location = center?.name ?? event.city;
  final end = event.dateEnd ?? event.dateStart.add(const Duration(hours: 2));

  cal.Add2Calendar.addEvent2Cal(
    cal.Event(
      title: event.title,
      description: event.description,
      location: location,
      startDate: event.dateStart,
      endDate: end,
    ),
  );
}
