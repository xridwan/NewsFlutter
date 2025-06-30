import 'package:news_app/features/bookmark/domain/model/bookmark.dart';

class BookmarkDto extends Bookmark {
  const BookmarkDto({
    required super.sourceId,
    required super.author,
    required super.title,
    required super.description,
    required super.publishedAt,
    required super.urlToImage,
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
}
