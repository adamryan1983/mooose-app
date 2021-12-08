import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mooose/constants/colors.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:mooose/controllers/mooseSightingsController.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mooose/services/geoService.dart';

class MapDisplay extends StatefulWidget {
  @override
  State createState() => _MapState();
}

class _MapState extends State<MapDisplay> {
  final MooseSightingsController sight = Get.find();
  final GeolocatorService geoService = GeolocatorService();
  geo.Position? position;
  Widget _child = SpinKitRipple(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.grey : Color(0xffffb838),
        ),
      );
    },
  );
  Completer<GoogleMapController> _controller = Completer();

  geo.Position? _currentPosition;

  _getCurrentLocation() async {
    await geo.Geolocator.getCurrentPosition(
            desiredAccuracy: geo.LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((geo.Position position) {
      setState(() {
        _currentPosition = position;
        _child = mapWidget();
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future centerScreen(geo.Position position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 18.0)));
  }

  void initState() {
    _getCurrentLocation();
    getMarker();
    geoService.getCurrentLocation().listen((position) {
      centerScreen(position);
    });
    super.initState();
  }

  late geo.LocationSettings locationSettings;

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/images/car_icon.png");
    return byteData.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
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
      body: _child,
    );
  }

  Widget mapWidget() {
    return Obx(() => GoogleMap(
        initialCameraPosition: CameraPosition(
            target:
                LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
            zoom: 14.6),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        compassEnabled: true,
        zoomControlsEnabled: true,
        myLocationEnabled: true,
        // circles: Set.of([circle]),
        // circles: Set.of(<Circle>[circle]),
        markers: Set<Marker>.of((sight.allSights()))));
  }
}
