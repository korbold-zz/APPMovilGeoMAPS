import 'dart:async';

import 'package:busmart/features/home/data/models/json_model.dart';
import 'package:busmart/features/home/data/repositories/home_data_repository_impl.dart';
import 'package:busmart/features/home/domain/entities/coordinates_mode.dart';
import 'package:busmart/features/home/data/models/home_model.dart';

import 'package:busmart/features/home/domain/repositories/home_domain_repository.dart';
import 'package:busmart/features/home/presentation/pages/data.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeBloc with ChangeNotifier {
  // StreamController<UserLocation> _locationController =
  //     StreamController<UserLocation>.broadcast();

  // bool _state = false;
  // final _homeDataRepository = HomeDataRepository();
  final HomeDomainRepositoryINTERFACE _homeDomainRepository;
  Set<Polyline> lines = {};
  final Set<Marker> _markers = {};

  HomeBloc(this._homeDomainRepository) {
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
  // Stream<UserLocation> get locationStream => _locationController.stream;

  // bool get getState => _state;

  //Google routes

  Future<List<RoutesModel>> getALLRoutes() async {
    final response = await _homeDomainRepository.getRoutesEntities();
    List<Coordinate> coordinate;

    try {
      print(response);
      for (var item in response) {
        coordinate = item.coordinates;

        final latLng = _getPoints(raw: coordinate);

        getRoutes1(latLng, Colors.red, item.id.toString());
      }
    } catch (e) {
      print('ERROR ROUTES $e');
    }
    return response;
  }

  /*  List<Routes> getNewRoutes() {
    final response = _homeDomainRepository.getRoutesEntities();
    for (var item in response) {
      final latLng = _getPoints(raw: item.route);
      getRoutes1(latLng, Colors.red, item.name);
      final latLngStopBus = _getPoints(raw: item.stopBus);

      for (var item1 in latLngStopBus) {
        setMarkers(item1, item.name);
      }
    }
    return response;
  } */

  List<LatLng> _getPoints({List<Coordinate> raw}) {
    return raw.map((e) => LatLng(e.latitude, e.length)).toList();
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
  }

  setMarkers(LatLng point, String name) {
    _markers.add(
      Marker(markerId: MarkerId(name), position: point),
    );
  }

  get getRoutes2 => lines;
  get getMarkers => _markers;
}
