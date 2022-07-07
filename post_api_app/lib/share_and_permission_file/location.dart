// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final geolocation =
      Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
  Position? _currentposition;
  String currentAddress = "";

  void getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentposition = position;
      });
      getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  void getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentposition!.latitude, _currentposition!.longitude);
      Placemark place = p[0];
      setState(() {
        currentAddress =
            "${place.subLocality},${place.administrativeArea},\n${place.country},${place.isoCountryCode},${place.name},";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(Icons.location_on),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: getCurrentLocation,
                            child: const Text("Get location")),
                        if (_currentposition != null && currentAddress != null)
                          Text(currentAddress, style: const TextStyle(fontSize: 18))
                        else
                          const Text("Cannot find the location")
                      ],
                    ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
