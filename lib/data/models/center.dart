class Center {
  const Center({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.lat,
    required this.lng,
    required this.phone,
    required this.hours,
    required this.createdAt,
  });

  final String id;
  final String name;
  final String city;
  final String address;
  final double lat;
  final double lng;
  final String phone;
  final String hours;
  final DateTime createdAt;

  factory Center.fromJson(Map<String, dynamic> json) {
    return Center(
      id: json['id'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      address: json['address'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      phone: json['phone'] as String,
      hours: json['hours'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'city': city,
        'address': address,
        'lat': lat,
        'lng': lng,
        'phone': phone,
        'hours': hours,
        'created_at': createdAt.toIso8601String(),
      };

  Center copyWith({
    String? id,
    String? name,
    String? city,
    String? address,
    double? lat,
    double? lng,
    String? phone,
    String? hours,
    DateTime? createdAt,
  }) {
    return Center(
      id: id ?? this.id,
      name: name ?? this.name,
      city: city ?? this.city,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      phone: phone ?? this.phone,
      hours: hours ?? this.hours,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Center && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
