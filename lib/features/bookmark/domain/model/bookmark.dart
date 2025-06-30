import 'package:equatable/equatable.dart';

class Bookmark extends Equatable {
  final String sourceId;
  final String author;
  final String title;
  final String description;
  final String publishedAt;
  final String urlToImage;

  const Bookmark({
    required this.sourceId,
    required this.author,
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.urlToImage,
  });

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
