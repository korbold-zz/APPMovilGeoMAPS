import 'package:busmart/features/home/data/models/json_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class HomeDomainRepositoryINTERFACE {
  Future<List<RoutesModel>> getRoutesEntities();
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2);
}
