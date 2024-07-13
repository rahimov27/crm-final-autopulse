import 'package:autopulse/resources/colors.dart';
import 'package:autopulse/resources/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui' as ui;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                                      const Text(
                                        '3000 mi',
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
                          "More detailed information about the car model can be displayed here."),
                      child: AspectRatio(
                        aspectRatio: 150 / 100.5,
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
                                  "Info",
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
                          "More detailed information about payment can be displayed here."),
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
}
