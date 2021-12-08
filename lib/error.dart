import 'package:flutter/material.dart';
import 'package:mooose/constants/colors.dart';

class ErrorPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mooose!',
        theme: ThemeData(
            primarySwatch: Colors.red,
            fontFamily: 'Work',
            backgroundColor: AppColors.MAINBGWHITE,
            primaryColor: AppColors.SECONDARY_COLOR),
        home: ErrorPageExtended());
  }
}

class ErrorPageExtended extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Image.asset('assets/images/moooseheaderlight.png',
            fit: BoxFit.cover, width: 150),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Uh Oh!',
              style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w700,
                  color: AppColors.FOURTH_COLOR),
            ),
            Container(
                child:
                    Image.asset('assets/images/mooose-logo.png', width: 270)),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Error Loading. Please close the app and try again.',
                  style: TextStyle(fontSize: 18),
                )),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child: Text(
                  'Click here to try again',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.FOURTH_COLOR),
                )),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
