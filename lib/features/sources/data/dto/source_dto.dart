import 'package:news_app/features/sources/domain/model/source.dart';

class SourceDto extends Source {
  const SourceDto({
    required super.id,
    required super.name,
    required super.description,
  });

  factory SourceDto.fromJson(Map<String, dynamic> json) {
    return SourceDto(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }
}
