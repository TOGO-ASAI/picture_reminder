class ImageModel {
  final int? id;
  final String? caption;
  final String imagePath;
  final DateTime takenAt;
  final int? reminderId;

  ImageModel({
    this.id,
    required this.caption,
    required this.imagePath,
    required this.takenAt,
    required this.reminderId,
  });

  factory ImageModel.fromMap(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'] as int?,
      caption: json['caption'] as String?,
      imagePath: json['image_path'] as String,
      takenAt: DateTime.parse(json['taken_at'] as String),
      reminderId: json['reminder_id'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'caption': caption,
      'image_path': imagePath,
      'taken_at': takenAt.toIso8601String(),
      'reminder_id': reminderId,
    };
  }
}
