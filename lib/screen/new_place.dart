import 'dart:developer';
import 'dart:io';

import 'package:favoriate_places/models/place.dart';
import 'package:favoriate_places/models/place_addrees.dart';
import 'package:favoriate_places/provider/favoraite_provider.dart';
import 'package:favoriate_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/image_Input.dart';

class NewPlace extends ConsumerStatefulWidget {
  const NewPlace({super.key});

  @override
  ConsumerState<NewPlace> createState() => _NewPlaceState();
}

late String enteredPlace;

bool isSaving = false;
final TextEditingController controller = TextEditingController();

class _NewPlaceState extends ConsumerState<NewPlace> {
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  File? _selectedImage;
  PlaceAddrees? _fullPlaceAddrees;
  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();

    void saveData() async {
      if (formkey.currentState!.validate() && _selectedImage != null) {
        formkey.currentState!.save();

        setState(() {
          isSaving = true;
        });

        await Future.delayed(const Duration(milliseconds: 700), () {
          setState(() {
            isSaving = false;
          });
        });
        ref.read(favoriateProvider.notifier).addPlace(Place(
            name: enteredPlace,
            image: _selectedImage!,
            placeAddrees: _fullPlaceAddrees!));

        if (!mounted) {
          return;
        }
        Navigator.pop(context);
      } else {
        return;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new place"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(5),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: controller,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLength: 30,
                  onSaved: (value) {
                    if (value != null) {
                      setState(() {
                        enteredPlace = value;
                        log(enteredPlace);
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length == 1) {
                      return "it must be between 2 and 30 Charchters";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Title",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ImageInput(
                  onSelectedImage: (image) {
                    _selectedImage = image;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                LocationInput(onSelectedFullAddrees: (placeAddress) {
                  _fullPlaceAddrees = placeAddress;
                }),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        saveData();
                      },
                      child: !isSaving
                          ? const SizedBox(
                              width: 75,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add),
                                  Text("Add place"),
                                ],
                              ),
                            )
                          : SizedBox(
                              width: 20,
                              height: 20,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    !isSaving
                        ? ElevatedButton(
                            onPressed: () {
                              controller.clear();
                              setState(() {
                                _selectedImage = null;
                              });
                            },
                            child: const Text("Reset"),
                          )
                        : const SizedBox(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
