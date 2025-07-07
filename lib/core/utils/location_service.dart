import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<GeoLoc?> getLocationCoords() async {
    LocationPermission status;

    try {
      status = await Geolocator.checkPermission();
      if (status == LocationPermission.denied ||
          status == LocationPermission.deniedForever) {
        status = await Geolocator.requestPermission();

        if (status == LocationPermission.denied ||
            status == LocationPermission.deniedForever)
          return null;
        else if (status == LocationPermission.whileInUse ||
            status == LocationPermission.always) {
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          GeoLoc geoLoc = GeoLoc(
            lng: position.longitude,
            lat: position.latitude,
          );

          print('lng ${position.longitude} lat ${position.latitude}');
          return geoLoc;
        }
      } else if (status == LocationPermission.whileInUse ||
          status == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
        );

        GeoLoc geoLoc = GeoLoc(
          lng: position.longitude,
          lat: position.latitude,
        );

        print('lng ${position.longitude} lat ${position.latitude}');
        return geoLoc;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (await Geolocator.isLocationServiceEnabled() == false) {
        GeoLoc geoLoc = GeoLoc(
          lng: 33.513876686466304,
          lat: 36.27653299855675,
        );
        return geoLoc;
      }

      rethrow;
    }
    return null;
  }

  static double calculateDistanceInKilo({
    required double lat1,
    required double lat2,
    required double lng1,
    required double lng2,
  }) {
    double distanceInMeters = Geolocator.distanceBetween(
      lat1,
      lng1,
      lat2,
      lng2,
    );
    return distanceInMeters / 1000;
  }
}

class GeoLoc extends Equatable {
  late double lat;
  late double lng;

  GeoLoc({required this.lat, required this.lng});

  GeoLoc.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }

  @override
  List<Object?> get props => [lat, lng];
}
