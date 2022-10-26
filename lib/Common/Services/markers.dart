import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarkers {
  static Set<Marker> _markers = {};

  static clearMarker() {
    _markers.clear();
  }

  static Set<Marker> get getMarker {
    return _markers;
  }

  static void makeMarkers(
      String name, String desc, double latitude, double longitude) {
    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(name),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(
        title: name,
        snippet: desc,
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
  }
}
