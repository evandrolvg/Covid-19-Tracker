import 'package:covid_19/helper/constant.dart';
import 'package:covid_19/views/info/my_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19/widgets/nearby/components/contact_card.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:covid_19/helper/constant.dart';

class NearbyInterface extends StatefulWidget {
  // static const String id = 'nearby_interface';

  @override
  _NearbyInterfaceState createState() => _NearbyInterfaceState();
}

class _NearbyInterfaceState extends State<NearbyInterface> {
  double offset = 0;
  Location location = Location();
  LocationData currentLocation;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Strategy strategy = Strategy.P2P_STAR;
  auth.User loggedInUser;
  String testText = '';
  final _auth = auth.FirebaseAuth.instance;
  List<dynamic> contactTraces = [];
  List<dynamic> contactTimes = [];
  List<dynamic> contactLocations = [];
  List<dynamic> contactInfected = [];

  void addContactsToList() async {
    await getCurrentUser();

    _firestore
        .collection('users')
        .doc(loggedInUser.email)
        .collection('met_with')
        .snapshots()
        .listen((snapshot) {
      for (var doc in snapshot.docs) {
        String currUsername = doc.data()['username'];
        bool currInfected =
            doc.data()['infected'] != null ? doc.data()['infected'] : false;
        DateTime currTime = doc.data().containsKey('contact time')
            ? (doc.data()['contact time'] as Timestamp).toDate()
            : null;
        GeoPoint currLocation = doc.data().containsKey('contact location')
            ? doc.data()['contact location']
            : null;

        if (!contactTraces.contains(currUsername)) {
          contactTraces.add(currUsername);
          contactTimes.add(currTime);
          contactLocations.add(currLocation);
          contactInfected.add(currInfected);
        }
      }
      setState(() {});
      // print(loggedInUser.email);
    });
  }

  void deleteOldContacts(int threshold) async {
    await getCurrentUser();
    DateTime timeNow = DateTime.now(); //get today's time

    _firestore
        .collection('users')
        .doc(loggedInUser.email)
        .collection('met_with')
        .snapshots()
        .listen((snapshot) {
      for (var doc in snapshot.docs) {
//        print(doc.data.containsKey('contact time'));
        if (doc.data().containsKey('contact time')) {
          DateTime contactTime = (doc.data()['contact time'] as Timestamp)
              .toDate(); // get last contact time
          // if time since contact is greater than threshold than remove the contact
          if (timeNow.difference(contactTime).inDays > threshold) {
            doc.reference.delete();
          }
        }
      }
    });

    setState(() {});
  }

  void discovery() async {
    try {
      bool a = await Nearby().startDiscovery(loggedInUser.email, strategy,
          onEndpointFound: (id, name, serviceId) async {
        print('FOUND id:$id -> name:$name'); // the name here is an email

        currentLocation = await location.getLocation();
        // (LatLng(currentLocation.latitude, currentLocation.longitude))
        GeoPoint point = new GeoPoint(currentLocation.latitude.toDouble(),
            currentLocation.longitude.toDouble());

        var docRef = _firestore.collection('users').doc(loggedInUser.email);

        docRef.collection('met_with').doc(name).set({
          'username': await getUsernameOfEmail(email: name),
          'contact time': DateTime.now(),
          'contact location': point,
          'infected': await getUserInfected(email: name)
        });
      }, onEndpointLost: (id) {
        print(id);
      });
      print('DISCOVERING: ${a.toString()}');
    } catch (e) {
      print(e);
    }
  }

  void stopDiscovery() async {
    try {
      await Nearby().stopDiscovery();

      print('STOP DISCOVERING}');
    } catch (e) {
      print(e);
    }
  }

  void getPermissions() {
    Nearby().askLocationAndExternalStoragePermission();
  }

  Future<String> getUsernameOfEmail({String email}) async {
    String res = '';
    await _firestore.collection('users').doc(email).get().then((doc) {
      if (doc.exists) {
        res = doc.data()['username'];
      } else {
        // doc.data() will be undefined in this case
        print("No such document!");
      }
    });
    return res;
  }

  Future<String> getUserInfected({String email}) async {
    String res = '';
    await _firestore.collection('users').doc(email).get().then((doc) {
      if (doc.exists) {
        res = doc.data()['infected'];
      } else {
        // doc.data() will be undefined in this case
        print("No such document!");
      }
    });
    return res;
  }

  Future<bool> getDataUserInfected() async {
    bool res = false;
    await getCurrentUser();

    await _firestore
        .collection('users')
        .doc(loggedInUser.email)
        .get()
        .then((doc) {
      if (doc.exists) {
        res = doc.data()['infected'];
        // setState(() => infected = doc.data()['infected']);
      } else {
        // doc.data() will be undefined in this case
        print("No such document!");
      }
    });
    return res;
  }

  Future<void> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {
        deleteOldContacts(14);
        addContactsToList();
        getPermissions();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isSwitch = false;
  bool dynamicSwitch;
  @override
  Widget build(BuildContext context) {
    handleSwitch(bool value) {
      _firestore
          .collection('users')
          .doc(loggedInUser.email)
          .update({"infected": value}).then((_) {
        print("success!");
      });
      setState(() {
        isSwitch = value;
        dynamicSwitch = value;
      });
    }

    return FutureBuilder(
        future: getDataUserInfected(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );

          dynamicSwitch = snapshot.data;
          print(snapshot.data);
          return Scaffold(
            body: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  MyHeader(
                    image: "assets/icons/coronadr.svg",
                    textTop: "COVID-19",
                    textBottom: "contact tracing.",
                    offset: offset,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("I'm infected"),
                        Padding(
                          padding: EdgeInsets.only(bottom: 30.0),
                          child: Switch(
                            value: dynamicSwitch != true
                                ? isSwitch
                                : dynamicSwitch,
                            onChanged: (val) {
                              handleSwitch(val);
                            },
                            activeTrackColor: kPrimaryColor,
                            activeColor: Colors.white,
                            inactiveTrackColor: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.only(bottom: 30.0),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            elevation: 5.0,
                            color: kPrimaryColor,
                            onPressed: () async {
                              try {
                                await Nearby().stopAdvertising();
                                stopDiscovery();
                                bool a = await Nearby().startAdvertising(
                                  loggedInUser.email,
                                  strategy,
                                  onConnectionInitiated: null,
                                  onConnectionResult: (id, status) {
                                    print(status);
                                  },
                                  onDisconnected: (id) {
                                    print('Disconnected $id');
                                  },
                                );

                                print('ADVERTISING ${a.toString()}');
                              } catch (e) {
                                print(e);
                              }

                              discovery();
                            },
                            child: Text(
                              'Start Tracing',
                              style: kButtonTextStyle,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 30.0),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            elevation: 5.0,
                            color: kDeathColor,
                            onPressed: () async {
                              stopDiscovery();
                            },
                            child: Text(
                              'Stop Tracing',
                              style: kButtonTextStyle,
                            ),
                          ),
                        ),
                      ]),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ContactCard(
                        imagePath: 'assets/images/wear_mask.png',
                        email: contactTraces[index],
                        infected: contactInfected[index],
                        contactUsername: contactTraces[index],
                        contactTime: contactTimes[index],
                        contactLocation: LatLng(
                            contactLocations[index].latitude.toDouble(),
                            contactLocations[index].longitude.toDouble()),
                      );
                    },
                    itemCount: contactTraces.length,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
