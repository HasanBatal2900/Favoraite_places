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
        Image.file(
          place.image,
          height: 400,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ]),
    );
  }
}
