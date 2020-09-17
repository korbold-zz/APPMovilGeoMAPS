import 'package:busmart/api_url.dart';
import 'package:busmart/features/home/data/models/home_model.dart';
import 'package:busmart/features/home/presentation/bloc/home_bloc.dart';
import 'package:busmart/features/home/presentation/pages/data.dart';
import 'package:busmart/features/home/presentation/widgets/sliding_widget.dart';
import 'package:busmart/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';
import "package:latlong/latlong.dart" as latLng;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<LoginBloc>(context);

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
            child: StreamProvider<UserLocation>(
              create: (context) => HomeBloc().locationStream,
              builder: (context, child) {
                final _bloc = Provider.of<UserLocation>(context);
                if (_bloc != null) {
                  return _Map();
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Padding(
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
          ),
          SlidingWidget(),
        ]),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.my_location), onPressed: () {}));
  }
}

class _Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<UserLocation>(context);

    return FlutterMap(
      options: MapOptions(
        center: latLng.LatLng(_bloc.latitude, _bloc.longitude),
        zoom: 16.0,
        maxZoom: 18.0,
        minZoom: 15.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "${ModeAppRun.apiMap}",
          additionalOptions: {
            'accessToken': '${ModeAppRun.acessTokenMap}',
            'id': 'mapbox.mapbox-traffic-v1'
          },
        ),
        PolylineLayerOptions(polylineCulling: true, polylines: [
          Polyline(
            points: getPoints(),
            // isDotted: true,
            color: Colors.transparent,
            strokeWidth: 10.0,
            borderColor: Color(0xFF1967D2),
            borderStrokeWidth: 5,
          )
        ]),
        MarkerLayerOptions(
          markers: [
            buildMarker(bloc: _bloc),
            buildMarkerPoints(getPoints()[0], Colors.green),
            buildMarkerPoints(getPoints()[getPoints().length - 1], Colors.red)
          ],
        ),
      ],
    );
  }

  Marker buildMarker({UserLocation bloc}) {
    return Marker(
      width: 50.0,
      height: 50.0,
      point: latLng.LatLng(bloc.latitude, bloc.longitude),
      builder: (ctx) => Container(
          child: Icon(
        Icons.person_pin_circle,
        size: 50,
      )),
    );
  }

  Marker buildMarkerPoints(LatLng location, Color color) {
    return Marker(
      width: 50.0,
      height: 50.0,
      point: latLng.LatLng(location.latitude, location.longitude),
      builder: (ctx) => Container(
          child: Icon(
        Icons.add_location,
        color: color,
        size: 30,
      )),
    );
  }
}