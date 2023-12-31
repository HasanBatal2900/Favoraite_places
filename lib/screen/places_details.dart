import 'package:favoriate_places/screen/map_preview.dart';
import 'package:flutter/material.dart';

import '../models/place.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key, required this.place});
  final Place place;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
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
          bottom: 100,
          child: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapScreen(place: place),
                )),
            child: const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage(
                "images/map.jpg",
              ),
            ),
          ),
        )
      ]),
    );
  }
}
