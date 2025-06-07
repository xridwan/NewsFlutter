import 'package:flutter/material.dart';
import 'package:news_app/core/utils/extension.dart';
import 'package:news_app/features/articles/domain/model/article.dart';

class ArticleItemWidget extends StatelessWidget {
  final Article article;
  final VoidCallback navigateToDetail;

  const ArticleItemWidget({
    super.key,
    required this.article,
    required this.navigateToDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      child: InkWell(
        onTap: navigateToDetail,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Text(
                article.description,
                style: TextStyle(fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 16),
              Text(
                article.publishedAt.toFormattedDate(),
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
