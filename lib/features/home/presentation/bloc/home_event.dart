import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeCameraMoveEvent with ChangeNotifier {
  LatLng _lastMapPosition;
  set onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
    notifyListeners();
  }

  get getCameraMove => _lastMapPosition;
}
