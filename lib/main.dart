import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooose/constants/colors.dart';
import 'package:mooose/controllers/mooseSightingsController.dart';
import 'package:provider/provider.dart';

import './controllers/dataController.dart';
import './error.dart';
import './models/user_location.dart';
import './tabs.dart';
import 'services/location_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AppExtended());
}

class MainApp extends StatelessWidget {
  // Instantiate your class using Get.put() to make it available for all "child" routes there.
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final SightingsController sightings = Get.put(SightingsController());
    final MooseSightingsController mooseSightings =
      Get.put(MooseSightingsController());

    return StreamProvider<UserLocation>(
      create: (_) => LocationService().locationStream,
      initialData: UserLocation(
        latitude: 0,
        longitude: 0,
      ),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mooose!',
        theme: ThemeData(
            primarySwatch: Colors.red,
            fontFamily: 'Work',
            backgroundColor: AppColors.MAINBGWHITE,
            primaryColor: AppColors.SECONDARY_COLOR),
        home: TabsPage()
      )
    );
    // return GetMaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     title: 'Mooose!',
    //     theme: ThemeData(
    //         primarySwatch: Colors.red,
    //         fontFamily: 'Work',
    //         backgroundColor: AppColors.MAINBGWHITE,
    //         primaryColor: AppColors.SECONDARY_COLOR),
    //     home: TabsPage());
  }
}

class AppExtended extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return ErrorPage();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MainApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Loading(key: UniqueKey());
      },
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Center(child: Text("Issue Loading.")));
  }
}

class Loading extends StatelessWidget {
  const Loading({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Container(child: Text("Loading up")));
  }
}
