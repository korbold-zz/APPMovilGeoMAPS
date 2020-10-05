import 'package:google_maps_flutter/google_maps_flutter.dart';

List<LatLng> getPoints({List<List<double>> raw}) {
  return raw.map((e) => LatLng(e[0], e[1])).toList();
}

List<List<double>> raw = [
  [-0.1795829, -78.480656],
  [-0.179717, -78.4798996],
  [-0.1817554, -78.4803019],
  [-0.1821524, -78.4788643],
  [-0.1845723, -78.4791322]
];
