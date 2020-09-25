import 'package:google_maps_flutter/google_maps_flutter.dart';

List<LatLng> getPoints({List<List<double>> raw}) {
  return raw.map((e) => LatLng(e[0], e[1])).toList();
}
