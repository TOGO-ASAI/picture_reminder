class Reminder {
  final int? id;
  final String title;
  final String? description;
  final DateTime reminderDate;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Reminder({
    this.id,
    required this.title,
    required this.description,
    required this.reminderDate,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Reminder.fromMap(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'] as int?,
      title: json['title'] as String,
      description: json['description'] as String?,
      reminderDate: DateTime.parse(json['reminder_date'] as String),
      isActive: json['is_active'] == 1,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'reminder_date': reminderDate.toIso8601String(),
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
