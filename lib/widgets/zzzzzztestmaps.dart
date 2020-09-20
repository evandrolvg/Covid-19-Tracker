// import 'package:covid_19/widgets/maps.dart';
// import 'package:flutter/material.dart';
// import 'package:location/location.dart';

// class MapsGoogle extends StatefulWidget {
//   MapsGoogle({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MapsGoogleState createState() => _MapsGoogleState();
// }

// class _MapsGoogleState extends State<MapsGoogle> {
//   @override
//   void initState() {
//     super.initState();
//     // _getLocationPermission();
//   }

//   // void _getLocationPermission() async {
//   //   var location = new Location();
//   //   try {
//   //     location.requestPermission();
//   //   } on Exception catch (_) {
//   //     print('There was a problem allowing location access');
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('teste'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'Using Google Maps in Flutter',
//                 style: TextStyle(fontSize: 42),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'The google_maps_flutter package is still in the Developers Preview status, so make sure you monitor changes closely when using it. There will likely be breaking changes in the near future.',
//                 style: TextStyle(fontSize: 20),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         tooltip: 'Increment',
//         child: Icon(Icons.map),
//         onPressed: () => Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => GMap()),
//         ),
//       ),
//     );
//   }
// }
