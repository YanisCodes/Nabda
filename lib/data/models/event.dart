import 'app_language.dart';
import 'event_category.dart';

class Event {
  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.city,
    required this.category,
    required this.dateStart,
    this.dateEnd,
    this.centerId,
    required this.isFree,
    this.imageUrl,
    required this.lang,
    required this.createdAt,
  });

  final String id;
  final String title;
  final String description;
  final String city;
  final EventCategory category;
  final DateTime dateStart;
  final DateTime? dateEnd;
  final String? centerId;
  final bool isFree;
  final String? imageUrl;
  final AppLanguage lang;
  final DateTime createdAt;

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      city: json['city'] as String,
      category: EventCategory.fromString(json['category'] as String),
      dateStart: DateTime.parse(json['date_start'] as String),
      dateEnd: json['date_end'] != null
          ? DateTime.parse(json['date_end'] as String)
          : null,
      centerId: json['center_id'] as String?,
      isFree: json['is_free'] as bool,
      imageUrl: json['image_url'] as String?,
      lang: AppLanguage.fromCode(json['lang'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'city': city,
    'category': category.name,
    'date_start': dateStart.toIso8601String(),
    'date_end': dateEnd?.toIso8601String(),
    'center_id': centerId,
    'is_free': isFree,
    'image_url': imageUrl,
    'lang': lang.code,
    'created_at': createdAt.toIso8601String(),
  };

  Event copyWith({
    String? id,
    String? title,
    String? description,
    String? city,
    EventCategory? category,
    DateTime? dateStart,
    DateTime? dateEnd,
    String? centerId,
    bool? isFree,
    String? imageUrl,
    AppLanguage? lang,
    DateTime? createdAt,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      city: city ?? this.city,
      category: category ?? this.category,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      centerId: centerId ?? this.centerId,
      isFree: isFree ?? this.isFree,
      imageUrl: imageUrl ?? this.imageUrl,
      lang: lang ?? this.lang,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Event && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
