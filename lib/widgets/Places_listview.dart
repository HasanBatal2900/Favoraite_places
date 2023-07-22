import 'package:flutter/material.dart';

import '../models/place.dart';
import '../screen/places_details.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});
  final List<Place> places;
  @override
  Widget build(BuildContext context) {
    return places.length == 0
        ? Center(
            child: Text(
              "No places added yet",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            itemCount: places.length,
            itemBuilder: (context, index) {
              return ListTile(
                enableFeedback: true,
                subtitle: Text(
                  places[index].placeAddrees.city +
                      " || " +
                      places[index].placeAddrees.countryName +
                      " || " +
                      places[index].placeAddrees.continent,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14),
                ),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: FileImage(
                    places[index].image,
                    scale: 1,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          animation = CurvedAnimation(
                              parent: animation, curve: Curves.fastOutSlowIn);
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return PlaceDetailsScreen(
                            place: places[index],
                          );
                        },
                      ));
                },
                title: Text(
                  places[index].name,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              );
            },
          );
  }
}
