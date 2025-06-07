import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final String desc;
  final VoidCallback navigateBack;

  const AppBarWidget({
    super.key,
    required this.title,
    required this.desc,
    required this.navigateBack,
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
      child: Row(
        children: [
          InkWell(onTap: navigateBack, child: Icon(Icons.arrow_back_ios)),
          SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 8),
                Text(
                  desc,
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
