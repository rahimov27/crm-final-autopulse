import 'package:autopulse/resources/colors.dart';
import 'package:autopulse/resources/fonts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui' as ui;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _accessToken;
  final Dio _dio = Dio();
  String? make;
  String? name;
  int? year;
  String? nickname;
  String? vin;
  String? imei;
  String? odometer;
  String? isRun;

  @override
  void initState() {
    super.initState();
    fetchAccessToken();
  }

  void _showCardModal(BuildContext context, String title, String content) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: AppColors.widgetsColors,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: AppFonts.widgetTitle,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    content,
                    style: AppFonts.widgetSubtitle,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150),
                  color: AppColors.appBarBackgroundColor,
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.iconsBackgroundColor.withOpacity(0.10),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/logo.svg',
                          width: 34,
                          height: 34,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      "Home",
                      style: AppFonts.appBarText,
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.iconsBackgroundColor.withOpacity(0.10),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/push.svg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () => _showCardModal(context, "Mileage",
                          "More detailed information about mileage can be displayed here."),
                      child: AspectRatio(
                        aspectRatio: 227 / 274,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.widgetsColors,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Mileage",
                                  style: AppFonts.widgetTitle,
                                ),
                                const Spacer(),
                                Center(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      ClipOval(
                                        child: BackdropFilter(
                                          filter: ui.ImageFilter.blur(
                                              sigmaX: 10, sigmaY: 10),
                                          child: Container(
                                            width: 180,
                                            height: 180,
                                            decoration: BoxDecoration(
                                              color: AppColors.widgetsColors
                                                  .withOpacity(0.1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 145,
                                        width: 145,
                                        child: CircularProgressIndicator(
                                          value: 0.75, // Represents 75%
                                          strokeWidth: 20,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  AppColors.mainBlueColor),
                                          backgroundColor: Colors.white12,
                                        ),
                                      ),
                                      Text(
                                        "${odometer.toString()} mi",
                                        style: AppFonts.milesText,
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  "Since last service",
                                  style: AppFonts.widgetSubtitle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.01), // dynamic spacing
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => _showCardModal(context, "Fuel",
                              "More detailed information about fuel level can be displayed here."),
                          child: AspectRatio(
                            aspectRatio: 113 / 134.5,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.widgetsColors,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Fuel",
                                      style: AppFonts.widgetTitle,
                                    ),
                                    Spacer(),
                                    Text("Level: 75%",
                                        style: AppFonts.widgetSubtitle),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenWidth * 0.01), // dynamic spacing
                        GestureDetector(
                          onTap: () => _showCardModal(context, "Engine",
                              "More detailed information about engine health can be displayed here."),
                          child: AspectRatio(
                            aspectRatio: 113 / 134.5,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.widgetsColors,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Engine",
                                      style: AppFonts.widgetTitle,
                                    ),
                                    Spacer(),
                                    Text("Health: Good",
                                        style: AppFonts.widgetSubtitle),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: screenWidth * 0.01), // dynamic spacing between rows
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () => _showCardModal(context, "Oil",
                          "More detailed information about oil level can be displayed here."),
                      child: AspectRatio(
                        aspectRatio: 150 / 200.5,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.widgetsColors,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Oil",
                                  style: AppFonts.widgetTitle,
                                ),
                                Spacer(),
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.red,
                                ),
                                Text(
                                  "500 miles",
                                  style: AppFonts.widgetSubtitle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.01), // dynamic spacing
                  Flexible(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () => _showCardModal(context, "Info",
                          "Model:$make - Name:$name - Year:$year, VIN$vin, IMEI$imei, Odometer:$odometer, Running-$isRun"),
                      child: AspectRatio(
                        aspectRatio: 150 / 100.5,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.widgetsColors,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Info",
                                  style: AppFonts.widgetTitle,
                                ),
                                const Spacer(),
                                Text("$make - $name \n$year",
                                    style: AppFonts.widgetSubtitle),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.01),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () => _showCardModal(context, "Maintenance",
                          "More detailed information about maintenance can be displayed here."),
                      child: AspectRatio(
                        aspectRatio: 150 / 100.5,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.widgetsColors,
                          ),
                          // ignore: prefer_const_constructors
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Maintenance",
                                  style: AppFonts.widgetTitle,
                                ),
                                Spacer(),
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.green,
                                ),
                                Text(
                                  "500 miles",
                                  style: AppFonts.widgetSubtitle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.01), // dynamic spacing
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () => _showCardModal(context, "Payment",
                          "Transaction ID : TX1234567890\nAmount: \$150.00\nDate: July 14, 2024\nPayment Method: Credit Card (Visa)"),
                      child: AspectRatio(
                        aspectRatio: 150 / 200.5,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.widgetsColors,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Payment",
                                  style: AppFonts.widgetTitle,
                                ),
                                Spacer(),
                                Text("Model: Tesla Model 3",
                                    style: AppFonts.widgetSubtitle),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
      'Authorization': '$_accessToken', // Added 'Bearer' for the token
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
        setState(() {
          make = response.data[0]['model']['make'];
          name = response.data[0]['model']['name'];
          year = response.data[0]['model']['year'];
          vin = response.data[0]["vin"];
          imei = response.data[0]["imei"];
          odometer = response.data[0]['stats']['odometer'].toString();
          isRun = response.data[0]['stats']['isRunning'].toString();
          print(odometer);
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
