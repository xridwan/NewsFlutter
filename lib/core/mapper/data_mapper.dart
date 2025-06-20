import 'package:news_app/features/sources/data/dto/source_dto.dart';
import 'package:news_app/features/sources/domain/model/source.dart';

import '../../features/articles/data/dto/article_dto.dart';
import '../../features/articles/domain/model/article.dart';
import '../../features/bookmark/data/dto/bookmark_dto.dart';
import '../../features/bookmark/domain/model/bookmark.dart';

extension SourceDtoMapper on SourceDto {
  Source toDomain() {
    return Source(id: id, name: name, description: description);
  }

  SourceDto toDto() {
    return SourceDto(id: id, name: name, description: description);
  }
}

extension ArticleMapper on ArticleDto {
  Article toDomain(sourceId) {
    return Article(
      sourceId: sourceId,
      author: author,
      title: title,
      description: description,
      publishedAt: publishedAt,
      urlToImage: urlToImage,
    );
  }
}

extension ArticleBookmark on Article {
  Bookmark toBookmark() {
    return Bookmark(
      sourceId: sourceId,
      author: author,
      title: title,
      description: description,
      publishedAt: publishedAt,
      urlToImage: urlToImage,
    );
  }
}

extension BookmarkDtoMapper on BookmarkDto {
  Bookmark toDomain() {
    return Bookmark(
      sourceId: sourceId,
      author: author,
      title: title,
      description: description,
      publishedAt: publishedAt,
      urlToImage: urlToImage,
    );
  }
}

extension BookmarkMapper on Bookmark {
  Article toArticle() {
    return Article(
      sourceId: sourceId,
      author: author,
      title: title,
      description: description,
      publishedAt: publishedAt,
      urlToImage: urlToImage,
    );
  }

  BookmarkDto toDto() {
    return BookmarkDto(
      sourceId: sourceId,
      author: author,
      title: title,
      description: description,
      publishedAt: publishedAt,
      urlToImage: urlToImage,
    );
  }
}
