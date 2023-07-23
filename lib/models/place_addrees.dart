class PlaceAddrees {
  // You can Add more details in the below link the follow details of the city from the api
  PlaceAddrees(
      {required this.city,
      required this.continent,
      required this.countryName,
      required this.lat,
      required this.long,
     }):imageUrl='https://maps.openstreetmap.de/staticmap.php?&referer=https://b.tile.openstreetmap.org/center=$lat,$long&zoom=13&size=500x300';
  String continent;
  String city;
  String countryName;
  double lat;
  double long;
  String imageUrl;
}
