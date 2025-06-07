import 'package:equatable/equatable.dart';

class Source extends Equatable {
  final String id;
  final String name;
  final String description;

  const Source({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
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
