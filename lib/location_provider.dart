import 'dart:math';

import 'package:location/location.dart';

class LocationProvider {
  Location location = Location();
  late bool serviceEnabled;
  late PermissionStatus permissionGranted;
  LocationProvider();

  Future<void> init() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  static LocationData canberra = LocationData.fromMap({
    'latitude': -32.962458,
    'longitude': 151.988705,
    'accuracy': 0,
    'speed': 0,
    'speed_accuracy': 0,
    'heading': 0,
    'time': DateTime.now().microsecondsSinceEpoch,
    'isMock': 1,
    'verticalAccuracy': 0,
    'headingAccuracy': 0,
    'elapsedRealtimeNanos': null,
    'elapsedRealtimeUncertaintyNanos': null,
    'satelliteNumber': null,
    'provider': null,
  });

  static LocationData singapore = LocationData.fromMap({
    'latitude': 4.171420,
    'longitude': 106.436114,
    'accuracy': 0,
    'speed': 0,
    'speed_accuracy': 0,
    'heading': 0,
    'time': DateTime.now().microsecondsSinceEpoch,
    'isMock': 1,
    'verticalAccuracy': 0,
    'headingAccuracy': 0,
    'elapsedRealtimeNanos': null,
    'elapsedRealtimeUncertaintyNanos': null,
    'satelliteNumber': null,
    'provider': null,
  });

  static LocationData sf = LocationData.fromMap({
    'latitude': -27.871392,
    'longitude': -54.859018,
    'accuracy': 0,
    'speed': 0,
    'speed_accuracy': 0,
    'heading': 0,
    'time': DateTime.now().microsecondsSinceEpoch,
    'isMock': 1,
    'verticalAccuracy': 0,
    'headingAccuracy': 0,
    'elapsedRealtimeNanos': null,
    'elapsedRealtimeUncertaintyNanos': null,
    'satelliteNumber': null,
    'provider': null,
  });

  static LocationData london = LocationData.fromMap({
    'latitude': 51.507351,
    'longitude': -0.127758,
    'accuracy': 0,
    'speed': 0,
    'speed_accuracy': 0,
    'heading': 0,
    'time': DateTime.now().microsecondsSinceEpoch,
    'isMock': 1,
    'verticalAccuracy': 0,
    'headingAccuracy': 0,
    'elapsedRealtimeNanos': null,
    'elapsedRealtimeUncertaintyNanos': null,
    'satelliteNumber': null,
    'provider': null,
  });

  static LocationData taipo = LocationData.fromMap({
    'latitude': 22.442322,
    'longitude': 114.165504,
    'accuracy': 0,
    'speed': 0,
    'speed_accuracy': 0,
    'heading': 0,
    'time': DateTime.now().microsecondsSinceEpoch,
    'isMock': 1,
    'verticalAccuracy': 0,
    'headingAccuracy': 0,
    'elapsedRealtimeNanos': null,
    'elapsedRealtimeUncertaintyNanos': null,
    'satelliteNumber': null,
    'provider': null,
  });

  static LocationData central = LocationData.fromMap({
    'latitude': 22.281981,
    'longitude': 114.161369,
    'accuracy': 0,
    'speed': 0,
    'speed_accuracy': 0,
    'heading': 0,
    'time': DateTime.now().microsecondsSinceEpoch,
    'isMock': 1,
    'verticalAccuracy': 0,
    'headingAccuracy': 0,
    'elapsedRealtimeNanos': null,
    'elapsedRealtimeUncertaintyNanos': null,
    'satelliteNumber': null,
    'provider': null,
  });

  Future<LocationData> getLocation() async {
    if (permissionGranted == PermissionStatus.granted) {
      return location.getLocation();
    } else {
      return central;
    }
  }

  static const double nearbyThresholdInKm = 20.0;

  static double getDistance(LocationData loc1, LocationData loc2) {
    // formula from https://stackoverflow.com/a/54138876
    var p = 0.017453292519943295;
    var lat1 = loc1.latitude ?? 0;
    var lon1 = loc1.longitude ?? 0;
    var lat2 = loc2.latitude ?? 0;
    var lon2 = loc2.longitude ?? 0;

    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
