import 'package:flutter/material.dart';

import '../../common/constans.dart';

class ReviewItem extends StatelessWidget {
  final String name;
  final String date;
  final String review;

  const ReviewItem({
    super.key,
    required this.name,
    required this.date,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: secondaryColor,
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            title: Transform.translate(
              offset: const Offset(0, -5),
              child: Text(
                name,
                style: primaryTextStyle.copyWith(
                  fontWeight: bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            subtitle: Text(
              date,
              style: primaryTextStyle,
            ),
          ),
          Divider(
            height: 1,
            color: primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              review,
              style: primaryTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
