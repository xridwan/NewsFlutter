import 'package:equatable/equatable.dart';

class SourceDto extends Equatable {
  final String id;
  final String name;
  final String description;

  const SourceDto({
    required this.id,
    required this.name,
    required this.description,
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

  @override
  List<Object?> get props => [id, name, description];
}
