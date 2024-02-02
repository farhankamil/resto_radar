import 'package:flutter/material.dart';
import 'package:resto_radar/presentation/widgets/review_tile.dart';

import '../../common/constans.dart';
import '../../data/models/restaurant_detail_model.dart';
import '../provider/restaurant_detail_provider.dart';
import 'add_review.dart';

class SheetReview extends StatelessWidget {
  final RestaurantDetail restaurant;
  final RestaurantDetailProvider provider;

  const SheetReview({
    super.key,
    required this.restaurant,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Review',
                    style: purpleTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return DialogReview(
                        provider: provider,
                        restaurantId: restaurant.id,
                      );
                    },
                  );
                },
                child: Text(
                  'Add Review',
                  style: purpleTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: restaurant.customerReviews.reversed.map((review) {
              return ReviewItem(
                name: review.name,
                date: review.date,
                review: review.review,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
