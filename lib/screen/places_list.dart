
import 'package:favoriate_places/provider/favoraite_provider.dart';
import 'package:favoriate_places/screen/new_place.dart';
import 'package:favoriate_places/widgets/Places_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class PlacesListScreen extends ConsumerStatefulWidget {
  const PlacesListScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PlacesListScreenState();
  }
}

class _PlacesListScreenState extends ConsumerState<PlacesListScreen> {
  late Future<void> _placesList;
  @override
  void initState() {
    super.initState();
    _placesList = ref.read(favoriateProvider.notifier).loadPLaces();
  }

  @override
  Widget build(BuildContext context) {
    final favoriatePlaces = ref.watch(favoriateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your places"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 500),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      animation = CurvedAnimation(
                          parent: animation, curve: Curves.easeInQuint);
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return const NewPlace();
                    },
                  ));
            },
            icon: const Icon(
              Icons.add,
              size: 20,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: _placesList,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(child: CircularProgressIndicator())
                  : PlacesList(places: favoriatePlaces)),
    );
  }
}
