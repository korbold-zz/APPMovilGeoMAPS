import 'package:busmart/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: unused_field
  MapboxMapController _mapController;

  void _onMapCreated(MapboxMapController controller) {
    _mapController = controller;
  }

  void onStyleLoadedCallback() {
    _mapController.addLine(
      LineOptions(
        geometry: [
          LatLng(-78.45280686131548, -0.09234684018113626),
          LatLng(-78.45280686131548, -0.09225557974190224),
          LatLng(-78.45196726419388, -0.09229208391717236),
          LatLng(-78.45144588479015, -0.09326514832800115),
        ],
        lineColor: "#ff0000",
        lineWidth: 5.0,
        lineOpacity: 0.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<LoginBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            GestureDetector(
              child: Icon(Icons.highlight_off),
              onTap: () {
                _bloc.signOut();
              },
            )
          ],
        ),
        body: MapboxMap(
          accessToken:
              'pk.eyJ1Ijoia29yYm9sZCIsImEiOiJjam1xaXdzZWcxcWNtM2tueW93M2RiZWIyIn0.AhIpztR_gxPxbScj9Vq0Sg',
          styleString: 'mapbox://styles/korbold/ckerognkr2ngo19mt4q3qoiii',
          onMapCreated: _onMapCreated,
          // onStyleLoadedCallback: onStyleLoadedCallback,
          initialCameraPosition: const CameraPosition(
              target: LatLng(-0.093086, -78.451799), zoom: 15),
        ));
  }
}
