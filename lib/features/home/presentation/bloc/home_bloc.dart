import 'dart:async';

import 'package:busmart/features/home/data/models/home_model.dart';
import 'package:busmart/features/home/data/repositories/home_data_repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomeBloc with ChangeNotifier {
  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  bool _state = false;
  HomeDataRepository _homeDataRepository;
  HomeBloc() {
    getPositionStream(
            desiredAccuracy: LocationAccuracy.best, timeInterval: 1000)
        .listen((Position position) {
      print(position == null
          ? 'Unknown'
          : position.latitude.toString() +
              ', ' +
              position.longitude.toString());

      _locationController.add(UserLocation(
          latitude: position.latitude, longitude: position.longitude));
      _state = true;
      notifyListeners();
    });
  }
  Stream<UserLocation> get locationStream => _locationController.stream;

  bool get getState => _state;

  //Mapbox routes

  getALLRoutes() async {
    return await _homeDataRepository.getRoutesEntities();
  }
}
