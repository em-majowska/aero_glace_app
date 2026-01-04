import 'package:latlong2/latlong.dart';

class ShopLocation {
  final String city;
  final String address;
  final LatLng coordinates;

  ShopLocation({
    required this.city,
    required this.address,
    required this.coordinates,
  });
}
