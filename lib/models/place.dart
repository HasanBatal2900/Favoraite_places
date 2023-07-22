import 'dart:io';

import 'package:favoriate_places/models/place_addrees.dart';
import 'package:uuid/uuid.dart';

class Place {
  Place({required this.name, required this.image,required this.placeAddrees}) : id = Uuid().v4();
  String name;
  String id;
  final File image;
  PlaceAddrees placeAddrees;
}
