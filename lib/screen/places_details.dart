import 'package:flutter/material.dart';

import '../models/place.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key, required this.place});
  final Place place;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: Stack(children: [
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: Image.file(
            place.image,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: 30,
          bottom: 60,
          child: Text(
            place.placeAddrees.city +
                " || " +
                place.placeAddrees.countryName +
                " || " +
                place.placeAddrees.continent,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.deepPurple.shade100,
          ),
        )
      ]),
    );
  }
}
