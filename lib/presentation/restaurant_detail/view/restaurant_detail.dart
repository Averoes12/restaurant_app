import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:restaurant_app/data/Restaurant.dart';
import 'package:restaurant_app/generated/assets.dart';

import '../../../style/styles.dart';

class RestaurantDetailScreen extends StatefulWidget {

  final RestaurantElement restaurant;
  const RestaurantDetailScreen({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  leading: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Icon(Icons.arrow_back, color: primaryColor,),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return SizedBox(
                              height: constraints.maxHeight,
                              child: Image.network(
                                widget.restaurant.pictureId,
                                width: constraints.maxWidth,
                                fit: BoxFit.cover,
                                errorBuilder: (context, err, _) {
                                  return const Center(
                                      child: Icon(Icons.broken_image_rounded, size: 48,)
                                  );
                                },
                                loadingBuilder: (context, child, loadingProgress) {
                                  if(loadingProgress == null) return child;
                                  return const SpinKitSquareCircle(
                                    size: 30,
                                    color: secondaryColor,
                                  );
                                },
                              ),
                            );
                          }
                        ),
                        Positioned(
                          bottom: 0,
                          width: constraints.maxWidth,
                          child: Container(
                            color: Colors.black54,
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.restaurant.name,
                                    style: Theme.of(context).textTheme.headline5?.copyWith(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on_rounded, color: secondaryColor, size: 20,),
                                        Text(widget.restaurant.city, style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                            color: primaryColor,
                                        ),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        RatingBarIndicator(
                                          itemCount: 5,
                                          rating: widget.restaurant.rating,
                                          itemSize: 20.0,
                                          unratedColor: Colors.grey,
                                          itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.yellow,),
                                        ),
                                        const SizedBox(width: 4,),
                                        Text(
                                          "${widget.restaurant.rating}",
                                          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                            color: primaryColor
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                      "Information",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 16,),
                        Text(widget.restaurant.description,
                          style: TextStyle(
                            color: Colors.grey[600]
                          ),
                        ),
                        const SizedBox(height: 16,),
                        Text(
                          "Menus",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 16,),
                        SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.restaurant.menus.foods.length,
                            itemBuilder: (context, index){
                              Food food = widget.restaurant.menus.foods[index];
                              return LayoutBuilder(
                                builder: (context, constraint) {
                                  return SizedBox(
                                    width: 120,
                                    child: Card(
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: 120,
                                            height: 120,
                                            decoration: const BoxDecoration(
                                              color: secondaryColor,
                                              borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                                              image: DecorationImage(
                                                image: AssetImage(Assets.assetsBibimbap),
                                                fit: BoxFit.scaleDown
                                              )
                                            ),
                                            padding: const EdgeInsets.all(8),
                                          ),
                                          const SizedBox(height: 8,),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              food.name, style: Theme.of(context).textTheme.labelMedium,
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16,),
                        SizedBox(
                          height: 170,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.restaurant.menus.drinks.length,
                            itemBuilder: (context, index){
                              Drink drink = widget.restaurant.menus.drinks[index];
                              return LayoutBuilder(
                                  builder: (context, constraint) {
                                    return SizedBox(
                                      width: 120,
                                      child: Card(
                                        child: Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              width: 120,
                                              height: 120,
                                              decoration: const BoxDecoration(
                                                  color: secondaryColor,
                                                  borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                                                  image: DecorationImage(
                                                      image: AssetImage(Assets.assetsOrangeJuice),
                                                      fit: BoxFit.scaleDown
                                                  )
                                              ),
                                              padding: const EdgeInsets.all(8),
                                            ),
                                            const SizedBox(height: 8,),
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                drink.name, style: Theme.of(context).textTheme.labelMedium,
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
