enum EventCategory {
  formation,
  sport,
  culture,
  ecologie,
  volontariat;

  static EventCategory fromString(String value) {
    return EventCategory.values.firstWhere(
      (c) => c.name == value,
      orElse: () => EventCategory.formation,
    );
  }
}
