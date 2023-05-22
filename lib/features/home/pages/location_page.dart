// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late PermissionStatus _permissionStatus;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _checkPermissionStatus();
  }

  Future<void> _checkPermissionStatus() async {
    final status = await Permission.locationWhenInUse.status;
    setState(() {
      _permissionStatus = status;
    });
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.locationWhenInUse.request();
    print(status);
    setState(() {
      _permissionStatus = status;
    });
  }

  Future<void> _getCurrentLocation() async {
    final status = await Permission.locationWhenInUse.request();
    print(status);
    setState(() {
      _permissionStatus = status;
    });
    if (_permissionStatus.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        Placemark placemark = placemarks[0];
        print(placemark.name);
        print(placemark.country);
        // if (placemarks.isNotEmpty) {
        //   Placemark placemark = placemarks[0];
        //   print(placemark.name);
        // String placeName = placemark.name;
        // String street = placemark.street;
        // String city = placemark.locality;
        // String state = placemark.administrativeArea;
        // String country = placemark.country;

        // Use the place information as needed
        // print('Place Name: $placeName');
        // print('Street: $street');
        // print('City: $city');
        // print('State: $state');
        // print('Country: $country');
        // }
        setState(() {
          _currentPosition = position;
        });
      } catch (e) {
        // Handle location retrieval errors
        print(e.toString());
      }
    } else if (_permissionStatus.isDenied ||
        _permissionStatus.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Permission Required'),
            content: Text(
                'Please grant location permission to access your current location.'),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text('Open Settings'),
                onPressed: () {
                  openAppSettings();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } else {
      await _requestLocationPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Access'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_currentPosition != null)
              Text(
                  'Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: Text('Get Current Location'),
            ),
          ],
        ),
      ),
    );
  }
}
