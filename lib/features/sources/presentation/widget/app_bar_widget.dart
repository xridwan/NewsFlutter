import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final VoidCallback navigateToBookmark;
  final VoidCallback navigateToSettings;
  final VoidCallback onSearch;

  const AppBarWidget({
    super.key,
    required this.navigateToBookmark,
    required this.navigateToSettings,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16, // Untuk status bar
        bottom: 18,
        left: 18,
        right: 18,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'News App',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Spacer(),
              InkWell(onTap: onSearch, child: Icon(Icons.search_rounded)),
              SizedBox(width: 8),
              InkWell(onTap: navigateToBookmark, child: Icon(Icons.bookmark)),
              SizedBox(width: 8),
              InkWell(onTap: navigateToSettings, child: Icon(Icons.settings)),
            ],
          ),
        ],
      ),
    );
  }
}
