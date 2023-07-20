import 'dart:io';

import 'package:uuid/uuid.dart';

class Place {
  Place({required this.name,required this.image}) : id = Uuid().v4();
  String name;
  String id;
  final File image;
}
