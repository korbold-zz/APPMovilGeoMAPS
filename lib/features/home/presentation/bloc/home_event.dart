import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CameraMoveEvent with ChangeNotifier {
  LatLng _lastMapPosition;
  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
    notifyListeners();
  }

  get getCameraMove => _lastMapPosition;
}
