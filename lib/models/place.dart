import 'dart:io';

import 'package:favoriate_places/models/place_addrees.dart';
import 'package:uuid/uuid.dart';

class Place {
  Place({required this.title, required this.image, required this.placeAddrees,String?id})
      : id = id ??Uuid().v4();
  String title;
  String id;
  final File image;
  PlaceAddrees placeAddrees;
}
