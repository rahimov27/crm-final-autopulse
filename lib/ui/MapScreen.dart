import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = [];
  String? _accessToken;
  double carLat = 32.999700;
  double carLon = -96.90000;

  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    fetchAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _controller.future,
        builder: (context, snapshot) {
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(carLat, carLon),
              zoom: 10.5,
            ),
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: fetchVehicleData,
      //   child: Icon(Icons.search),
      // ),
    );
  }

  Future<void> fetchAccessToken() async {
    final url = 'https://auth.bouncie.com/oauth/token';
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': '*/*',
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive',
      'User-Agent': 'PostmanRuntime/7.40.0',
    };
    final body = {
      'client_id': 'my-car',
      'client_secret': 'SdlvlNPTncFaAdC9c16SuCGXJg78hoGWirgXdR2tRXQqUsx8gj',
      'grant_type': 'authorization_code',
      'code':
          'SuUtacd689iT9eLwL4iC01CsMdgJoC2AWyjBfok6mtBFyFwvo3', // Replace with your actual code
      'redirect_uri': 'http://127.0.0.1:5501/app.html',
    };

    try {
      final response = await _dio.post(
        url,
        options: Options(headers: headers),
        data: body,
      );

      if (response.statusCode == 200) {
        _accessToken = response.data['access_token'];
        // print('Access token: $_accessToken');
        fetchVehicleData();
      } else {
        print(
            'Failed to send POST request. Status code: ${response.statusCode}');
        print('Response body: ${response.data}');
      }
    } catch (e) {
      if (e is DioError) {
        print('Error sending POST request: ${e.response?.data}');
        print(
            'DioError details: ${e.response?.statusCode}, ${e.response?.statusMessage}');
      } else {
        print('Unexpected error: $e');
      }
    }
  }

  Future<void> fetchVehicleData() async {
    if (_accessToken == null) {
      print('No access token available.');
      return;
    }

    final url = 'https://api.bouncie.dev/v1/vehicles';
    final headers = {
      'Authorization': '$_accessToken',
      'Accept': '*/*',
      'User-Agent': 'PostmanRuntime/7.40.0',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    };

    try {
      final response = await _dio.get(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        // print('Full response data: ${response.data}');
        final List<dynamic> responseBody = response.data;
        setState(() {
          _markers.clear();
          for (var vehicle in responseBody) {
            if (vehicle['stats'] != null &&
                vehicle['stats']['location'] != null) {
              carLat = vehicle['stats']['location']['lat'];
              carLon = vehicle['stats']['location']['lon'];
              // print('Car Lat: $carLat, Car Lon: $carLon');

              final marker = Marker(
                markerId: MarkerId(vehicle['nickName']),
                position: LatLng(carLat, carLon),
                infoWindow: InfoWindow(
                  title:
                      vehicle['model']['make'] + ' ' + vehicle['model']['name'],
                  snippet: 'Nickname: ' + vehicle['nickName'],
                ),
              );
              _markers.add(marker);

              // Move the camera to the new location
              _controller.future.then((controller) {
                controller.animateCamera(
                    CameraUpdate.newLatLng(LatLng(carLat, carLon)));
              });
            } else {
              print(
                  'Vehicle location data is null for vehicle: ${vehicle['nickName']}');
            }
          }
        });
      } else {
        print(
            'Failed to fetch vehicle data. Status code: ${response.statusCode}');
        print('Response body: ${response.data}');
      }
    } catch (e) {
      if (e is DioError) {
        print('Error fetching vehicle data: ${e.response?.data}');
        print(
            'DioError details: ${e.response?.statusCode}, ${e.response?.statusMessage}');
      } else {
        print('Unexpected error: $e');
      }
    }
  }
}
