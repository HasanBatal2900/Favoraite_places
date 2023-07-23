import 'dart:convert';
import 'dart:developer';

import 'package:favoriate_places/models/place_addrees.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectedFullAddrees});

  final Function(PlaceAddrees) onSelectedFullAddrees;
  @override
  State<LocationInput> createState() => _LocationInputState();
}

PlaceAddrees? pickedLocation;
bool isGettingLocation = false;
double? long;
double? lat;
bool showMap = false;

class _LocationInputState extends State<LocationInput> {

  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      isGettingLocation = true;
    });

    locationData = await location.getLocation();
    long = locationData.longitude;
    lat = locationData.latitude;

    if (lat == null || long == null) {
      return;
    }
    print(locationData.longitude);
    print(locationData.latitude);

    final url = Uri.parse(
        "https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=$lat&longitude=$long");

    final respone = await http.get(url);
    final data = json.decode(respone.body);

    final cityName = data["city"];
    final continent = data["continent"];
    final countryName = data["countryName"];
  

    pickedLocation = PlaceAddrees(
        city: cityName,
        continent: continent,
        countryName: countryName,
        lat: lat!,
        long: long!,
      );

    widget.onSelectedFullAddrees(pickedLocation!);
    log(pickedLocation!.city);

    setState(() {
      isGettingLocation = false;
      showMap = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text("No location selected",
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ));

    if (isGettingLocation) {
      previewContent = CircularProgressIndicator(
        color: Theme.of(context).colorScheme.primary,
      );
    }

    if (showMap) {
      previewContent = FlutterMap(
        options: MapOptions(
          center: LatLng(lat!, long!),
          zoom: 9.2,
        ),
        nonRotatedChildren: [
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () =>
                    launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
          ),
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.flutter_map_app.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(lat!, long!),
                builder: (context) => const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
          //"staticmap.php?center=40.714728,-73.998672&zoom=14&size=865x512&maptype=mapnik"
          CircleLayer(
            circles: [
              CircleMarker(
                  point: LatLng(lat!, long!),
                  radius: 10000,
                  useRadiusInMeter: true,
                  color: Colors.green.withOpacity(0.6),
                  borderColor: Colors.black.withOpacity(0.6),
                  borderStrokeWidth: 5),
            ],
          ),
          RichAttributionWidget(
            animationConfig: const ScaleRAWA(), // Or `FadeRAWA` as is default
            attributions: [
              TextSourceAttribution(
                'My Parntenrs Open Street contributors',
                onTap: () =>
                    launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
          ),
        ],
      );
    }

    return Column(
      children: [
        Container(
            height: 500,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
            ),
            child: previewContent),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text("Get current location"),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text(
                "Pick from  map",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
