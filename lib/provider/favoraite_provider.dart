import 'dart:io';

import 'package:favoriate_places/models/place.dart';
import 'package:favoriate_places/models/place_addrees.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> getDataBase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, "places.db"),
    onCreate: (db, version) {
      db.execute(
          "CREATE TABLE user_places (id TEXT PRIMARY KEY ,title TEXT, image TEXT,lat REAL,long REAL,city TEXT ,continent TEXT,countryName TEXT )");
      return;
    },
    version: 1,
  );

  return db;
}

class FavoriateNotifier extends StateNotifier<List<Place>> {
  FavoriateNotifier() : super([]);

  Future<void> loadPLaces() async {
    final db = await getDataBase();

    final data = await db.query(
      "user_places",
    );

    final places = data
        .map((row) => Place(
            id: row["id"] as String,
            title: row["title"] as String,
            image: File(row["image"] as String),
            placeAddrees: PlaceAddrees(
                city: row["city"] as String,
                continent: row["continent"] as String,
                countryName: row["countryName"] as String,
                lat: row["lat"] as double,
                long: row["long"] as double)))
        .toList();

    state = places;
  }

  void addPlace(Place place) async {
//////////
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(place.image.path);
    final copyedImage = place.image.copy("${appDir.path}/$fileName");
//////////////////
    final db = await getDataBase();
    db.insert("user_places", {
      "id": place.id,
      "title": place.title,
      "image": place.image.path,
      "city": place.placeAddrees.city,
      "continent": place.placeAddrees.continent,
      "countryName": place.placeAddrees.countryName,
      "lat": place.placeAddrees.lat,
      "long": place.placeAddrees.long,
    });

    state = [place, ...state];
  }
}

final favoriateProvider = StateNotifierProvider<FavoriateNotifier, List<Place>>(
    (ref) => FavoriateNotifier());
