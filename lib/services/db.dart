import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FirestoreDB {
  // Initialise Firebase Cloud Firestore
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;

  Stream<Set<Marker>> getAllSightings() {
    return FirebaseFirestore.instance
        .collection('sightings')
        .where('time',
            isGreaterThan: DateTime.now().subtract(new Duration(days: 1)))
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Marker(
          markerId: MarkerId(doc.id),
          icon: customIcon,
          position: LatLng(doc.data()['location'].latitude,
              doc.data()['location'].longitude),
          infoWindow: InfoWindow(
            title: "Moose Sighting",
            snippet: doc.data()['time'].toDate().toString(),
          ),
        );
      }).toSet();
    });
  }
}
