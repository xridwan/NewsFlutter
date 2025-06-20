import 'package:equatable/equatable.dart';

class BookmarkDto extends Equatable {
  final String sourceId;
  final String author;
  final String title;
  final String description;
  final String publishedAt;
  final String urlToImage;

  const BookmarkDto({
    required this.sourceId,
    required this.author,
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.urlToImage,
  });

  factory BookmarkDto.fromJson(Map<String, dynamic> json) {
    return BookmarkDto(
      sourceId: json['sourceId'] ?? '',
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sourceId': sourceId,
      'author': author,
      'title': title,
      'description': description,
      'publishedAt': publishedAt,
      'urlToImage': urlToImage,
    };
  }

  @override
  List<Object?> get props => [
    sourceId,
    author,
    title,
    description,
    publishedAt,
    urlToImage,
  ];
}
