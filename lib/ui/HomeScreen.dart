import 'package:autopulse/resources/colors.dart';
import 'package:autopulse/resources/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui' as ui;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  SizedBox(width: screenWidth * 0.01), // dynamic spacing
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        AspectRatio(
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
                        SizedBox(height: screenWidth * 0.01), // dynamic spacing
                        AspectRatio(
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
                                  Text(
                                    "Health: Good",
                                    style: AppFonts.widgetSubtitle,
                                  ),
                                ],
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
                  SizedBox(width: screenWidth * 0.01), // dynamic spacing
                  Flexible(
                    flex: 2,
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
                ],
              ),
              SizedBox(height: screenWidth * 0.01),
              Row(
                children: [
                  Flexible(
                    flex: 2,
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
                  SizedBox(width: screenWidth * 0.01), // dynamic spacing
                  Flexible(
                    flex: 1,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
