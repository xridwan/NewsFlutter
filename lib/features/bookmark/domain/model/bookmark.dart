import 'package:equatable/equatable.dart';

class Bookmark extends Equatable {
  final String author;
  final String title;
  final String description;
  final String publishedAt;
  final String urlToImage;

  const Bookmark({
    required this.author,
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.urlToImage,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'publishedAt': publishedAt,
      'urlToImage': urlToImage,
    };
  }

  @override
  List<Object?> get props => [
    author,
    title,
    description,
    publishedAt,
    urlToImage,
  ];
}
