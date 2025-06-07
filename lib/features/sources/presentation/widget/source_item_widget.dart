import 'package:flutter/material.dart';
import 'package:news_app/features/sources/domain/model/source.dart';

class SourceItemWidget extends StatelessWidget {
  final Source source;
  final VoidCallback navigateToArticle;

  const SourceItemWidget({
    super.key,
    required this.source,
    required this.navigateToArticle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      child: InkWell(
        onTap: navigateToArticle,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                source.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Text(
                source.description,
                style: TextStyle(fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
