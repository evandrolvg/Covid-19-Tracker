import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMap extends StatefulWidget {
  final LatLng contactLocation;
  // GMap({@required this.contactLocation});
  GMap({this.contactLocation});

  // final Color colour;
  // final String title;

  // GMap({Key key}) : super(key: key);

  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  Set<Marker> _markers = HashSet<Marker>();

  // ignore: unused_field
  GoogleMapController _mapController;

  // get contactLocation => this.contactLocation;
  // BitmapDescriptor _markerIcon;

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    LatLng _contactLocation = widget.contactLocation;
    _mapController = controller;

    setState(() {
      if (_markers != null) {
        _markers.add(Marker(
          markerId: MarkerId('1'),
          infoWindow: InfoWindow(title: 'CONTINENT ', snippet: 'POPULATION '),
          position: _contactLocation,
          // icon: _markerIcon
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    LatLng _contactLocation = widget.contactLocation;
    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _contactLocation,
              zoom: 19,
            ),
            mapType: MapType.satellite,
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            zoomGesturesEnabled: true,
          ),
        ],
      ),
    );
  }
}
