import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:restaurant_app/data/Restaurant.dart';
import 'package:restaurant_app/generated/assets.dart';
import 'package:restaurant_app/style/styles.dart';

import '../../../routes/Routes.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {

  final searchController = TextEditingController();
  List<RestaurantElement> _filteredList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            constraints: constraints,
            child: Column(
              children: [
                Container(
                  constraints: constraints,
                  height: 200,
                  padding: const EdgeInsets.only(left: 16.0, top: 52, right: 16.0),
                  decoration: const BoxDecoration(
                    color: secondaryColor
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Restaurant',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.white
                        ),
                      ),
                      const SizedBox(height: 16.0,),
                      TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14.0)),
                            borderSide: BorderSide(
                              style: BorderStyle.none,
                              width: 0
                            )
                          ),
                          filled: true,
                          fillColor: primaryColor,
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          hintText: 'What would you like ?',
                          prefixIcon: const Icon(Icons.search),
                          prefixIconColor: Colors.grey[800]
                        ),
                        cursorColor: secondaryColor,
                        onChanged: (value){
                          setState(() {});
                        },
                      )
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                    constraints: constraints,
                    child: SingleChildScrollView(
                      child: FutureBuilder<String>(
                        future: DefaultAssetBundle.of(context).loadString(Assets.assetsRestaurant),
                        builder: (context, snapshot){
                          if(snapshot.data != null && snapshot.connectionState == ConnectionState.done){
                            final  Restaurant restaurant = restaurantFromJson(snapshot.data!);
                            final List<RestaurantElement>item = restaurant.restaurants;
                            _filteredList.clear();
                            _filteredList.addAll(item);
                            if(searchController.value.text.isNotEmpty){
                              _filteredList = _filteredList.where((e) => e.name.toLowerCase().contains(searchController.value.text.toLowerCase())).toList();
                            }
                            if(_filteredList.isNotEmpty){
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: _filteredList.map((e) {
                                    var imgUrl = NetworkImage(e.pictureId);
                                    return GestureDetector(
                                      onTap: (){
                                        Navigator.pushNamed(
                                          context,
                                          Routes.restaurantDetail.toString(),
                                          arguments: e
                                        );
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 200,
                                              child: ClipRRect(
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10)
                                                ),
                                                child: Image.network(
                                                  e.pictureId,
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
                                              ),
                                            ),
                                            const SizedBox(height: 8.0,),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                e.name,
                                                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(Icons.location_on_rounded, color: secondaryColor,size: 14,),
                                                      Text(e.city, style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                                          color: Colors.grey[600],
                                                          fontWeight: FontWeight.bold
                                                      ),)
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      RatingBarIndicator(
                                                        itemCount: 5,
                                                        rating: e.rating,
                                                        itemSize: 20.0,
                                                        itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.yellow,),
                                                      ),
                                                      const SizedBox(width: 4,),
                                                      Text("${e.rating}")
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              );
                            }else {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(Assets.assetsSmartphone,
                                      width: 200,
                                      height: 280,
                                    ),
                                    Text(
                                      'Not Data Found',
                                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: SpinKitSquareCircle(
                              color: secondaryColor,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
