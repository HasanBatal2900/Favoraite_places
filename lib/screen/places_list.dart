import 'package:favoriate_places/constraints.dart/pageBuilder.dart';
import 'package:favoriate_places/provider/favoraite_provider.dart';
import 'package:favoriate_places/widgets/Places_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesListScreen extends ConsumerWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriatePlaces = ref.watch(favoriateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your places"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, newPageBuilder);
            },
            icon: const Icon(
              Icons.add,
              size: 20,
            ),
          )
        ],
      ),
      body: PlacesList(places: favoriatePlaces),
    );
  }
}
