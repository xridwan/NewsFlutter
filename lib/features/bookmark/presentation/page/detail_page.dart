import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/mapper/data_mapper.dart';
import 'package:news_app/core/utils/extension.dart';
import 'package:news_app/features/articles/domain/model/article.dart';
import 'package:news_app/features/bookmark/presentation/widget/floating_bookmark_widget.dart';

class DetailPage extends StatelessWidget {
  final Article article;

  const DetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingBookmarkWidget(bookmark: article.toBookmark()),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            expandedHeight: 250,
            pinned: false,
            floating: true,
            snap: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      article.urlToImage,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) =>
                              Container(color: Colors.grey.shade300),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
              expandedTitleScale: 1.5,
              title: Text(
                article.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              titlePadding: EdgeInsets.all(16),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList.list(
              children: [
                Text(
                  article.author,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 16),
                Text(article.publishedAt.toFormattedDate()),
                SizedBox(height: 16),
                Text(
                  article.description,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
