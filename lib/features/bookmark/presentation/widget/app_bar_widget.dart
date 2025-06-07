import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final VoidCallback navigateBack;

  const AppBarWidget({super.key, required this.navigateBack});

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
          const SizedBox(width: 16),
          Text(
            'Bookmark',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
