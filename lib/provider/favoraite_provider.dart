import 'package:favoriate_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriateNotifier extends StateNotifier<List<Place>> {
  FavoriateNotifier() : super([]);

  void addPlace(Place place) {
    state = [place, ...state];
  }

}

final favoriateProvider = StateNotifierProvider<FavoriateNotifier, List<Place>>(
    (ref) => FavoriateNotifier());
