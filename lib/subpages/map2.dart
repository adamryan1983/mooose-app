// import 'dart:async';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:mooose/constants/colors.dart';
// import 'package:mooose/controllers/dataController.dart';
//
// class Map2 extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<Map2> {
//   StreamSubscription? _locationSubscription;
//   Location _locationTracker = Location();
//
//   final LocationController loc = Get.find();
//
//   Position? position;
//
//   Marker? marker;
//   Widget? _child;
//
//   Circle circle = Circle(
//       circleId: CircleId("car"),
//       radius: 4,
//       zIndex: 1,
//       strokeColor: Colors.blue,
//       center: _center,
//       fillColor: Colors.blue.withAlpha(70));
//   late GoogleMapController _controller;
//
//   static const LatLng _center = const LatLng(47.560539, -52.712830);
//
//   @override
//   void initState() {
//     _child = SpinKitRipple(
//       itemBuilder: (BuildContext context, int index) {
//         return DecoratedBox(
//           decoration: BoxDecoration(
//             color: index.isEven ? Colors.grey : Color(0xffffb838),
//           ),
//         );
//       },
//     );
//     getCurrentLocation();
//     super.initState();
//   }
//
//   static final CameraPosition initialLocation = CameraPosition(
//     target: LatLng(47.560539, -52.712830),
//     zoom: 9.4746,
//   );
//
//   Future<Uint8List> getMarker() async {
//     ByteData byteData = await DefaultAssetBundle.of(context).load(
//         "assets/images/car_icon.png");
//     return byteData.buffer.asUint8List();
//   }
//
//   void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
//     LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
//     setState(() {
//       marker = Marker(
//           markerId: MarkerId("home"),
//           position: latlng,
//           rotation: newLocalData.heading!,
//           draggable: false,
//           zIndex: 2,
//           flat: true,
//           anchor: Offset(0.5, 0.5),
//           icon: BitmapDescriptor.fromBytes(imageData));
//       circle = Circle(
//           circleId: CircleId("car"),
//           radius: newLocalData.accuracy!,
//           zIndex: 1,
//           strokeColor: Colors.blue,
//           center: latlng,
//           fillColor: Colors.blue.withAlpha(70));
//     });
//   }
//
//   void getCurrentLocation() async {
//     try {
//       Uint8List imageData = await getMarker();
//       var location = await _locationTracker.getLocation();
//       print("works");
//       setState(() {
//         _child = mapWidget();
//       });
//
//       updateMarkerAndCircle(location, imageData);
//
//       if (_locationSubscription != null) {
//         _locationSubscription?.cancel();
//       }
//
//       _locationSubscription =
//           _locationTracker.onLocationChanged.listen((newLocalData) {
//               _controller.animateCamera(
//                   CameraUpdate.newCameraPosition(new CameraPosition(
//                       bearing: 192.8334901395799,
//                       target: LatLng(
//                           newLocalData.latitude!, newLocalData.longitude!),
//                       tilt: 0,
//                       zoom: 18.00)));
//               updateMarkerAndCircle(newLocalData, imageData);
//           });
//     } on PlatformException catch (e) {
//       if (e.code == 'PERMISSION_DENIED') {
//         debugPrint("Permission Denied");
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     if (_locationSubscription != null) {
//       _locationSubscription?.cancel();
//     }
//     super.dispose();
//   }
//
//   Set<Marker> _createMarker() {
//     return <Marker>[
//       Marker(
//           markerId: MarkerId("Home"),
//           position: LatLng(position!.latitude, position!.longitude),
//           icon: BitmapDescriptor.defaultMarker,
//           infoWindow: InfoWindow(title: "Moose Sighting")
//       )
//     ].toSet();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.FOURTH_COLOR,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_rounded),
//           tooltip: 'Back',
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Image.asset('assets/images/moooseheader.png',
//             fit: BoxFit.cover, width: 150),
//       ),
//       body: _child,
//     );
//   }
//
//   Widget mapWidget() {
//     return Stack(
//       children: <Widget>[
//         GoogleMap(
//             initialCameraPosition: initialLocation,
//             onMapCreated: (GoogleMapController controller) {
//               _controller = controller;
//             },
//             compassEnabled: true,
//             zoomControlsEnabled: true,
//             myLocationEnabled: true,
//             // circles: Set.of((circle != null) ? [circle] : []),
//             circles: Set.of(<Circle>[circle]),
//             // markers: Set<Marker>.of((_markers2))
//             markers: _createMarker(),
//         ),
//         SizedBox(
//           height: 26,
//         ),
//       ],
//     );
//   }
// }