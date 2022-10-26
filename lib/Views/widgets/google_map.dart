import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guard_app/services/location_services.dart';
import 'package:guard_app/services/markers.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  List<double> location = [];
  Set<Marker> markers = {};
  var center;
  var _lastMapPosition;
  bool loading = true;

  void getLocation() async {
    var temp = await LocationServices.getLatLong();
    var loc = MapMarkers.getMarker;

    setState(() {
      location = temp;
      markers = loc;
      center = LatLng(location[0], location[1]);
      _lastMapPosition = center;
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLocation();
  }

  Completer<GoogleMapController> _controller = Completer();

  @override
  void _onAddMarkerButtonPressed() {
    setState(() {
      markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {

    setState(() {
       _lastMapPosition = position.target;
    });
   
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Center(
            child: SingleChildScrollView(),
          )
        : Stack(
            children: <Widget>[
              GoogleMap(
                onMapCreated: _onMapCreated,
                markers: markers,
                onCameraMove: _onCameraMove,
                initialCameraPosition: CameraPosition(
                  target: center,
                  zoom: 11.0,
                ),
              ),
              
            ],
          );
  }
}
