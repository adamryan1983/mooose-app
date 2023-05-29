//google map display
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mooose/controllers/mooseSightingsController.dart';
import 'package:mooose/services/geoService.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../models/marked_sighting.dart';
import '../models/user_location.dart';

class Map2 extends StatefulWidget {
  const Map2({Key? key}) : super(key: key);

  @override
  _Map2State createState() => _Map2State();
}

class _Map2State extends State<Map2> {
  final MooseSightingsController sight = Get.find();
  Set<Marker> markers = Set();
  final GeolocatorService geoService = GeolocatorService();

  geo.Position? _currentPosition;

  void initState() {
        super.initState();
    // _getLocationPermission();
    _getCurrentLocation();
    getCurrentLocation();
    addMarkers();
    // geoService.getCurrentLocation().listen((position) {
    //   centerScreen(position);
    // });
  }

  @override
  void dispose() {

    super.dispose(); // This will free the memory space allocated to the page
  }

  LocationData? currentLocation;
  getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
        compareToMarkers();
      },
    );
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 18,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
      },
    );
  }
  _getCurrentLocation() async {
    await geo.Geolocator.getCurrentPosition(
            desiredAccuracy: geo.LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((geo.Position position) {
      setState(() {
        _currentPosition = position;
        // _child = mapWidget();
      });
    }).catchError((e) {
      print(e);
    });
  }

  //compare markers to current location
  void compareToMarkers() {
    if (currentLocation != null) {
      for (Marker marker in markers) {
        if ((marker.position.latitude <= (currentLocation!.latitude! + 3) || marker.position.latitude >= (currentLocation!.latitude! - 1))  &&
            (marker.position.longitude <= currentLocation!.longitude! + 3) || marker.position.longitude >= currentLocation!.longitude! - 1) {
          print("warning!");
        } 
      }
    }
  }

  addMarkers() async {
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/moose.png",
    );
    for (MarkedSighting sighting in sight.allSightPositions) {
      final marker = Marker(
        markerId: MarkerId(sighting.id.toString()),
        position: LatLng(sighting.latitude!, sighting.longitude!),
        infoWindow: InfoWindow(
          title: sighting.blurb,
          snippet: sighting.time.toString(),
        ),
        icon: markerbitmap,
      );
      markers.add(marker);
    }
  }

  Future centerScreen(geo.Position position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 18.0)));
  }

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.FOURTH_COLOR,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Image.asset('assets/images/moooseheader.png',
            fit: BoxFit.cover, width: 150),
      ),
      body: _currentPosition == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(userLocation.latitude!, userLocation.longitude!),
                zoom: 18.0,
              ),
              markers: markers,
              compassEnabled: true,
              zoomControlsEnabled: true,
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
      // ? const Center(child: Text("Loading"))
      // : MapWidget(context),
    );
  }

  Completer<GoogleMapController> _controller = Completer();
  // Widget MapWidget(BuildContext context) {
  //   return
  //   Container(
  //     child: GoogleMap(
  //       onMapCreated: (GoogleMapController controller) {
  //         _controller.complete(controller);
  //       },
  //       compassEnabled: true,
  //       zoomControlsEnabled: true,
  //       myLocationEnabled: true,
  //       initialCameraPosition: CameraPosition(
  //           target: LatLng(userLocation.latitude,sourceLocation.longitude), zoom: 18),
  //       markers: markers,
  //     ),
  //   );
  // }
}
