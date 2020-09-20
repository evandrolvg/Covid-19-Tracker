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
  Set<Polygon> _polygons = HashSet<Polygon>();
  Set<Polyline> _polylines = HashSet<Polyline>();
  Set<Circle> _circles = HashSet<Circle>();
  // bool _showMapStyle = false;

  GoogleMapController _mapController;
  // BitmapDescriptor _markerIcon;

  @override
  void initState() {
    super.initState();
    // _setMarkerIcon();
    _setPolygons();
    _setPolylines();
    _setCircles();
  }

  // void _setMarkerIcon() async {
  //   _markerIcon = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(), 'assets/images/marker.png');
  // }

  // void _toggleMapStyle() async {
  //   String style = await DefaultAssetBundle.of(context)
  //       .loadString('assets/map_style.json');

  //   if (_showMapStyle) {
  //     _mapController.setMapStyle(style);
  //   } else {
  //     _mapController.setMapStyle(null);
  //   }
  // }

  void _setPolygons() {
    List<LatLng> polygonLatLongs = List<LatLng>();
    polygonLatLongs.add(LatLng(37.78493, -122.42932));
    polygonLatLongs.add(LatLng(37.78693, -122.41942));
    polygonLatLongs.add(LatLng(37.78923, -122.41542));
    polygonLatLongs.add(LatLng(37.78923, -122.42582));

    _polygons.add(
      Polygon(
        polygonId: PolygonId("0"),
        points: polygonLatLongs,
        fillColor: Colors.white,
        strokeWidth: 1,
      ),
    );
  }

  void _setPolylines() {
    List<LatLng> polylineLatLongs = List<LatLng>();
    polylineLatLongs.add(LatLng(37.74493, -122.42932));
    polylineLatLongs.add(LatLng(37.74693, -122.41942));
    polylineLatLongs.add(LatLng(37.74923, -122.41542));
    polylineLatLongs.add(LatLng(37.74923, -122.42582));

    _polylines.add(
      Polyline(
        polylineId: PolylineId("0"),
        points: polylineLatLongs,
        color: Colors.purple,
        width: 1,
      ),
    );
  }

  void _setCircles() {
    _circles.add(
      Circle(
          circleId: CircleId("0"),
          center: LatLng(37.76493, -122.42432),
          radius: 1000,
          strokeWidth: 2,
          fillColor: Color.fromRGBO(102, 51, 153, .5)),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    setState(() {
      if (_markers != null) {
        final liveCountry = Provider.of<AllData>(context, listen: false);
        // _markers.add(
        //   Marker(
        //       markerId: MarkerId("0"),
        //       position: LatLng(37.77483, -122.41942),
        //       infoWindow: InfoWindow(
        //         title: "San Francsico",
        //         snippet: "An Interesting city",
        //       ),
        //       icon: _markerIcon),
        // );

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
              // target: LatLng(37.77483, -122.41942),
              target: LatLng(
                  (liveCountry.oneResponse.data['countryInfo']['lat'] as num)
                      .toDouble(),
                  (liveCountry.oneResponse.data['countryInfo']['long'] as num)
                      .toDouble()),
              zoom: 2,
            ),
            markers: _markers,
            polygons: _polygons,
            polylines: _polylines,
            circles: _circles,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            zoomGesturesEnabled: true,
          ),
          // Container(
          //   alignment: Alignment.bottomCenter,
          //   padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
          //   child: Text("Coding with Curry"),
          // )
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //   tooltip: 'Increment',
      //   child: Icon(Icons.map),
      //   onPressed: () {
      //     setState(() {
      //       _showMapStyle = !_showMapStyle;
      //     });

      //     _toggleMapStyle();
      //   },
      // ),
    );
  }
}
