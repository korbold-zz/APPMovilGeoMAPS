import 'dart:async';

import 'package:busmart/features/home/data/models/coordinates_mode.dart';
import 'package:busmart/features/home/data/models/home_model.dart';
import 'package:busmart/features/home/data/models/json_model.dart';
import 'package:busmart/features/home/data/repositories/home_data_repository.dart';
import 'package:busmart/features/home/presentation/pages/data.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeBloc with ChangeNotifier {
  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  bool _state = false;
  final _homeDataRepository = HomeDataRepository();

  Set<Polyline> lines = {};

  HomeBloc() {
    // getRoutes1(getPoints(raw: _raw), Colors.red, '1');
    // getRoutes1(getPoints(raw: _raw2), Colors.blue, '2');

    // getPositionStream(
    //         desiredAccuracy: LocationAccuracy.best, timeInterval: 1000)
    //     .listen((Position position) {
    //   print(position == null
    //       ? 'Unknown'
    //       : position.latitude.toString() +
    //           ', ' +
    //           position.longitude.toString());

    //   _locationController.add(UserLocation(
    //       latitude: position.latitude, longitude: position.longitude));
    //   _state = true;
    //   notifyListeners();
    // });
  }
  Stream<UserLocation> get locationStream => _locationController.stream;

  bool get getState => _state;

  //Google routes

  Future getALLRoutes() async {
    try {
      final response = await _homeDataRepository.getRoutesEntities();
      for (var item in response) {
        final res = item.journeyOptional;

        final coordinates = coordModelFromJson(res).coordinates;
        final latLng = _getPoints(raw: coordinates);
        getRoutes1(latLng, Colors.red, item.id.toString());
      }
    } catch (e) {
      print('ERROR ROUTES $e');
    }
  }

  List<RutasModel> _routeModel;
  Future getALLRoutesNames() async {
    try {
      return await _homeDataRepository.getRoutesEntities();
    } catch (e) {
      print('ERROR ROUTES $e');
    }
  }

  List<LatLng> _getPoints({List<List<double>> raw}) {
    return raw.map((e) => LatLng(e[0], e[1])).toList();
  }

  //

  getRoutes1(List<LatLng> ponits, Color color, String name) {
    lines.add(Polyline(
      points: ponits,
      color: color,
      endCap: Cap.roundCap,
      width: 6,
      geodesic: false,
      polylineId: PolylineId(name),
    ));
    // notifyListeners();
  }

  get getRoutes2 => lines;
}
