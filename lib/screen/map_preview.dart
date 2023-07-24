import 'package:favoriate_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.place});

  final Place place;
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late double lat;
  late double long;

  @override
  void initState() {
    super.initState();
    lat = widget.place.placeAddrees.lat;
    long = widget.place.placeAddrees.long;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Map View"),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(lat, long),
              zoom: 9.2,
            ),
            nonRotatedChildren: [
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () => launchUrl(
                        Uri.parse('https://openstreetmap.org/copyright')),
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
                    point: LatLng(lat, long),
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
                      point: LatLng(lat, long),
                      radius: 10000,
                      useRadiusInMeter: true,
                      color: Colors.green.withOpacity(0.6),
                      borderColor: Colors.black.withOpacity(0.6),
                      borderStrokeWidth: 5),
                ],
              ),
              RichAttributionWidget(
                animationConfig:
                    const ScaleRAWA(), // Or `FadeRAWA` as is default
                attributions: [
                  TextSourceAttribution(
                    'My Parntenrs Open Street contributors',
                    onTap: () => launchUrl(
                        Uri.parse('https://openstreetmap.org/copyright')),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
