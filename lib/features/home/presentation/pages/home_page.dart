import 'package:busmart/api_url.dart';
import 'package:busmart/features/home/data/models/json_model.dart';
import 'package:busmart/features/home/domain/repositories/home_domain_repository.dart';
import 'package:busmart/features/home/presentation/bloc/home_bloc.dart';
import 'package:busmart/features/home/presentation/bloc/home_event.dart';

import 'package:busmart/features/home/presentation/widgets/sliding_widget.dart';
import 'package:busmart/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:search_map_place/search_map_place.dart';

GoogleMapController mapController;

CameraPosition _initialPosition =
    CameraPosition(target: LatLng(-0.217538, -78.5055006), zoom: 16);

void _onMapCreated(GoogleMapController controller) {
  mapController = controller;
}

class HomePage extends StatelessWidget {
  HomePage._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          HomeBloc(Provider.of<HomeDomainRepositoryINTERFACE>(context))
            ..getALLRoutes(),
      builder: (_, __) => HomePage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<LoginBloc>(context);
    final _homeBloc = Provider.of<HomeBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          GestureDetector(
            child: Icon(Icons.power_settings_new),
            onTap: () {
              _bloc.signOut();
            },
          ),
          SizedBox(
            width: 30,
          )
        ],
      ),
      body: Stack(children: [
        Container(
          // child: StreamProvider<UserLocation>(
          //   create: (context) => HomeBloc().locationStream,
          //   builder: (context, child) {
          //     final _bloc = Provider.of<UserLocation>(context);
          //     if (_bloc != null) {
          //       return
          child: _Map(),
          //     } else {
          //       return Center(child: CircularProgressIndicator());
          //     }
          //   },
          // ),
        ),
        // Search(),
        SearchMapPlaceWidget(
          apiKey: ModeAppRun.apiGoogleMaps,
          placeType: PlaceType.address,
          placeholder: 'Ej. Mitad del Mundo',
          language: 'es',
          onSelected: (Place place) async {
            Geolocation geolocation = await place.geolocation;
            mapController
                .animateCamera(CameraUpdate.newLatLng(geolocation.coordinates));
            mapController.animateCamera(
                CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
          },
        ),

        /*  Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 70,
            child: FutureBuilder(
              future: _homeBloc.getALLRoutes(),
              builder: (context, AsyncSnapshot<List<RoutesModel>> snapshot) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, value) {
                      final data = snapshot.data
                          .map((e) => e.journeyOptional[0])
                          .toList();
                      return CardRoute(
                        // name: data,
                        latLng: LatLng(data[0] as double, data[1] as double),
                      );
                    });
              },
            ),
          ),
        ) */
        // SlidingWidget(),
      ]),
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.my_location), onPressed: () {})
    );
  }
}

class Search extends StatelessWidget {
  const Search({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Row(children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Ejemplo: Mitad del Mundo',
              ),
            ),
          ),
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ]),
      ),
    );
  }
}

class CardRoute extends StatelessWidget {
  final LatLng latLng;
  final String name;
  const CardRoute({
    Key key,
    this.latLng,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.blue,
        width: 200,
        child: Card(
            elevation: 5,
            child: ListTile(
              title: Text(name),
            )),
      ),
      onTap: () {
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: latLng, zoom: 15.0),
          ),
        );
      },
    );
  }
}

class _Map extends StatefulWidget {
  @override
  __MapState createState() => __MapState();
}

class __MapState extends State<_Map> {
  Set<Polyline> lines = {};

  @override
  void initState() {
    lines.add(
      Polyline(
        points: [
          LatLng(-0.1795829, -78.480656),
          LatLng(-0.179717, -78.4798996),
          LatLng(-0.1817554, -78.4803019),
          LatLng(-0.1821524, -78.4788643),
          LatLng(-0.1845723, -78.4791322),
        ],
        endCap: Cap.squareCap,
        geodesic: false,
        polylineId: PolylineId("line_one"),
      ),
    );
    HomeEvent().initNotificationsPemision();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<HomeBloc>(context, listen: false);

    return GoogleMap(
      initialCameraPosition: _initialPosition,
      onMapCreated: _onMapCreated,
      // onCameraMove: _cameraEvent.getCameraMove,
      myLocationButtonEnabled: true,
      mapType: MapType.normal,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: false,
      polylines: _bloc.getRoutes2,
      markers: _bloc.getMarkers,
    );
  }
}
