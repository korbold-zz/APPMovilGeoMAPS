import 'dart:async';

import 'package:busmart/features/home/data/models/home_model.dart';
import 'package:busmart/features/home/presentation/bloc/home_bloc.dart';
import 'package:busmart/features/home/presentation/bloc/home_event.dart';
import 'package:busmart/features/home/presentation/pages/data.dart';
import 'package:busmart/features/home/presentation/widgets/sliding_widget.dart';
import 'package:busmart/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
// import "package:latlong/latlong.dart" as latLng;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  @override
  void initState() {
    super.initState();
    
  }

  void loadMapRoutes() async{
    final _bloc1 = Provider.of<HomeBloc>(
      context,
    );
    _bloc1.getALLRoutes();
    await Future.delayed(Duration(seconds: 5));
  }

  Widget build(BuildContext context) {
    final _bloc = Provider.of<LoginBloc>(
      context,
    );
     final _bloc1 = Provider.of<HomeBloc>(
      context
    );

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

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              height: 100,
              child: GridView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1),
                  itemBuilder: (context, value) {
                    return Card(
                      elevation: 5,
                      child: Container(
                        color: Colors.amberAccent,
                        width: 300,
                      ),
                    );
                  })),
        )
        // SlidingWidget(),
      ]),
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.my_location), onPressed: () {})
    );
  }
}

CameraPosition _initialPosition = CameraPosition(
    target: LatLng(0.35202334859913265, -78.12685826626091), zoom: 16);
Completer<GoogleMapController> _controller = Completer();

void _onMapCreated(GoogleMapController controller) {
  _controller.complete(controller);
}

class _Map extends StatefulWidget {
  @override
  __MapState createState() => __MapState();
}

class __MapState extends State<_Map> {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<HomeBloc>(context);

    final _cameraEvent = Provider.of<CameraMoveEvent>(context);
    return GoogleMap(
      initialCameraPosition: _initialPosition,
      onMapCreated: _onMapCreated,
      onCameraMove: _cameraEvent.getCameraMove,
      myLocationButtonEnabled: true,
      mapType: MapType.normal,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: false,
      polylines: _bloc.getRoutes2,
    );
  }
}
