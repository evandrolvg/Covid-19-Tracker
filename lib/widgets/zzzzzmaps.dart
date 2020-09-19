// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// //import 'package:covid_19/widgets/GeoJson.dart';

// // void main() => runApp(Maps());

// class Maps extends StatefulWidget {
//   @override
//   _MapsState createState() => _MapsState();
// }

// class _MapsState extends State<Maps> {
//   var polygon;

//   var point;
//   GoogleMapController mapController;
//   @override
//   // ignore: override_on_non_overriding_member
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   @override
//   void initState() {
//     addPoints();
//     List<Polygon> addPolygon = [
//       Polygon(
//         polygonId: PolygonId('India'),
//         points: point,
//         consumeTapEvents: true,
//         strokeColor: Colors.grey,
//         strokeWidth: 1,
//         fillColor: Colors.redAccent,
//       ),
//     ];
//     polygon.addAll(addPolygon);

//     super.initState();
//   }

//   void addPoints() {
//     for (var i = 0; i < GeoJson.IN.length; i++) {
//       var ltlng = LatLng(GeoJson.IN[i][1], GeoJson.IN[i][0]);
//       point.add(ltlng);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       onMapCreated: _onMapCreated,
//       initialCameraPosition:
//           CameraPosition(target: LatLng(45.521563, -122.677433), zoom: 0.0),
//       scrollGesturesEnabled: true,
//       zoomGesturesEnabled: true,
//       myLocationButtonEnabled: false,
//       gestureRecognizers: Set()
//         ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
//       //markers: markers,
//       polygons: polygon,
//     );
//   }
// }
