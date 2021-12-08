import 'package:flutter/material.dart';
import 'package:mooose/constants/colors.dart';

class ImportantInfo extends StatelessWidget {
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
              'Information',
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                  color: AppColors.FOURTH_COLOR),
            ),
            Container(
                child:
                    Image.asset('assets/images/mooose-logo.png', width: 270)),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'This app is designed to help travellers in Newfoundland to spot and report moose sightings.',
                  style: TextStyle(fontSize: 18),
                )),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Please remember to follow proper provincial guidelines with cellular usage and please do not operate your device while driving',
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
