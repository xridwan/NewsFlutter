import 'package:flutter/material.dart';
import 'package:news_app/core/utils/extension.dart';
import 'package:news_app/features/bookmark/domain/model/bookmark.dart';

class BookmarkItemWidget extends StatelessWidget {
  final Bookmark bookmark;
  final VoidCallback navigateToDetail;

  const BookmarkItemWidget({
    super.key,
    required this.bookmark,
    required this.navigateToDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      child: InkWell(
        onTap: navigateToDetail,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bookmark.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                bookmark.description,
                style: TextStyle(fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Text(
                bookmark.publishedAt.toFormattedDate(),
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
