import 'package:news_app/features/articles/domain/model/article.dart';

class ArticleDto extends Article {
  const ArticleDto({
    required super.sourceId,
    required super.author,
    required super.title,
    required super.description,
    required super.publishedAt,
    required super.urlToImage,
  });

  factory ArticleDto.fromJson(Map<String, dynamic> json) {
    return ArticleDto(
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
