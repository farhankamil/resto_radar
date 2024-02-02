import 'package:flutter/material.dart';

import '../../common/constans.dart';

class TextMessage extends StatelessWidget {
  final String image;
  final String message;
  final Function()? onPressed;

  const TextMessage({
    super.key,
    required this.image,
    required this.message,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 150,
            width: 150,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: primaryTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          if (onPressed != null)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: primaryColor, // Warna teks
              ),
              onPressed: onPressed,
              child: const Text(
                'Refresh',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
