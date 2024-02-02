import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:resto_radar/presentation/widgets/sheet_review.dart';
import 'package:resto_radar/presentation/widgets/review_tile.dart';
import '../../common/constans.dart';
import '../../data/models/restaurant_detail_model.dart';
import '../../data/models/restaurant_list_model.dart';
import '../provider/database_provider.dart';
import '../provider/restaurant_detail_provider.dart';

import 'card_menu.dart';

class ContentRestaurant extends StatefulWidget {
  final RestaurantDetail restaurant;
  final RestaurantDetailProvider provider;

  const ContentRestaurant({
    super.key,
    required this.restaurant,
    required this.provider,
  });

  @override
  State<ContentRestaurant> createState() => _ContentRestaurantState();
}

class _ContentRestaurantState extends State<ContentRestaurant> {
  @override
  Widget build(BuildContext context) {
    final heightImage = MediaQuery.of(context).size.height * 0.6;
    final widthImage = MediaQuery.of(context).size.width;
    final review = widget.restaurant.customerReviews.last;

    return Consumer<DatabaseProvider>(
      builder: (_, providerFavorite, __) {
        return FutureBuilder(
          future: providerFavorite.isFavorited(widget.restaurant.id),
          builder: (_, snapshot) {
            final isFavorited = snapshot.data ?? false;

            return Stack(
              children: [
                SizedBox(
                  height: heightImage,
                  width: widthImage,
                  child: Stack(
                    children: [
                      Container(
                        height: heightImage,
                        width: widthImage,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://restaurant-api.dicoding.dev/images/large/${widget.restaurant.pictureId}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.5,
                  maxChildSize: 1.0,
                  minChildSize: 0.5,
                  builder: (context, scrollController) {
                    return Container(
                      decoration: BoxDecoration(
                        color: backgroundColor1,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    height: 4,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.restaurant.name,
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 25,
                                      fontWeight: bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  isFavorited
                                      ? ElevatedButton(
                                          onPressed: () {
                                            providerFavorite.removeFavorite(
                                              widget.restaurant.id,
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                duration: Duration(seconds: 1),
                                                content: Text(
                                                  'Dihapuskan dari favorit',
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.favorite,
                                            size: 28,
                                          ),
                                        )
                                      : ElevatedButton(
                                          onPressed: () {
                                            providerFavorite.addFavorite(
                                              Restaurant(
                                                id: widget.restaurant.id,
                                                name: widget.restaurant.name,
                                                description: widget
                                                    .restaurant.description,
                                                city: widget.restaurant.city,
                                                pictureId:
                                                    widget.restaurant.pictureId,
                                                rating:
                                                    widget.restaurant.rating,
                                              ),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                duration: Duration(seconds: 1),
                                                content: Text(
                                                  'Ditambahkan ke favorit',
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.favorite_border,
                                            size: 28,
                                          ),
                                        ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RatingBarIndicator(
                                    rating: widget.restaurant.rating,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    unratedColor: backgroundColor6,
                                    itemSize: 18,
                                  ),
                                  Text(
                                    ' | ${widget.restaurant.rating}',
                                    style: primaryTextStyle.copyWith(
                                      fontWeight: medium,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_pin,
                                    size: 23,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.restaurant.city,
                                    style: primaryTextStyle.copyWith(
                                      fontWeight: medium,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              ReadMoreText(
                                widget.restaurant.description,
                                style: primaryTextStyle,
                                trimLines: 4,
                                colorClickableText: primaryColor,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: ' Show more',
                                trimExpandedText: '  Show less',
                                moreStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Categories :",
                                style: primaryTextStyle,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                height: 35,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: widget.restaurant.categories.map(
                                    (category) {
                                      return Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        child: Center(
                                          child: Text(
                                            category.name,
                                            style: primaryTextStyle.copyWith(
                                              fontWeight: bold,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                "Makanan :",
                                style: primaryTextStyle,
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                height: 180,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 8,
                                  ),
                                  children:
                                      widget.restaurant.menus.foods.map((food) {
                                    return CardMenu(
                                      image: 'assets/images/ic_food.png',
                                      name: food.name,
                                    );
                                  }).toList(),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                "Minuman :",
                                style: primaryTextStyle,
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                height: 180,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 8,
                                  ),
                                  children: widget.restaurant.menus.drinks
                                      .map((drink) {
                                    return CardMenu(
                                      image: 'assets/images/ic_juice.png',
                                      name: drink.name,
                                    );
                                  }).toList(),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ReviewItem(
                                name: review.name,
                                date: review.date,
                                review: review.review,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          backgroundColor: backgroundColor1,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(18),
                                              topRight: Radius.circular(18),
                                            ),
                                          ),
                                          builder: (context) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20,
                                              ),
                                              child: SheetReview(
                                                provider: widget.provider,
                                                restaurant: widget.restaurant,
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Text(
                                        'Lihat Review',
                                        style: purpleTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
