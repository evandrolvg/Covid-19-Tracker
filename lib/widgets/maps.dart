import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:covid_19/helper/api_covid.dart';
import 'package:covid_19/helper/constant.dart';

class GMap extends StatefulWidget {
  GMap({Key key}) : super(key: key);

  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  Set<Marker> _markers = HashSet<Marker>();

  // ignore: unused_field
  GoogleMapController _mapController;
  // BitmapDescriptor _markerIcon;

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    setState(() {
      if (_markers != null) {
        final liveCountry = Provider.of<AllData>(context, listen: false);
        _markers.add(Marker(
          markerId:
              MarkerId(liveCountry.oneResponse.data['countryInfo']['flag']),
          infoWindow: InfoWindow(
              title: 'CONTINENT ' +
                  liveCountry.oneResponse.data['continent'].toString(),
              snippet: 'POPULATION ' +
                  n.format(liveCountry.oneResponse.data['population'])),
          position: LatLng(
              (liveCountry.oneResponse.data['countryInfo']['lat'] as num)
                  .toDouble(),
              (liveCountry.oneResponse.data['countryInfo']['long'] as num)
                  .toDouble()),
          // icon: _markerIcon
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final liveCountry = Provider.of<AllData>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  (liveCountry.oneResponse.data['countryInfo']['lat'] as num)
                      .toDouble(),
                  (liveCountry.oneResponse.data['countryInfo']['long'] as num)
                      .toDouble()),
              zoom: 3,
            ),
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
