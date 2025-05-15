class Medication {
  final String id;
  final String name;
  final String dosage;
  final DateTime time;
  final String userId;
  final bool taken;

  Medication({
    required this.id,
    required this.name,
    required this.dosage,
    required this.time,
    required this.userId,
    this.taken = false,
  });

  // Convierte el objeto a un JSON para Appwrite (sin el campo id porque lo genera automáticamente)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dosage': dosage,
      'time': time.toIso8601String(),
      'userId': userId,
      'taken': taken,
    };
  }

  // Crea un objeto Medication a partir del JSON recibido de Appwrite
  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['\$id'] ?? '', // Appwrite devuelve el ID con la clave '$id'
      name: json['name'] ?? '',
      dosage: json['dosage'] ?? '',
      time: DateTime.parse(json['time']),
      userId: json['userId'] ?? '',
      taken: json['taken'] ?? false,
    );
  }

  // Crea una copia del objeto actual con los campos que quieras modificar
  Medication copyWith({
    String? id,
    String? name,
    String? dosage,
    DateTime? time,
    String? userId,
    bool? taken,
  }) {
    return Medication(
      id: id ?? this.id,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      time: time ?? this.time,
      userId: userId ?? this.userId,
      taken: taken ?? this.taken,
    );
  }
}
