import 'package:flutter/material.dart';

class EmptyDataWidget extends StatelessWidget {
  final String message;

  const EmptyDataWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/empty_icon.png', width: 200, height: 200),
        const SizedBox(height: 20),
        Text(
          message,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
