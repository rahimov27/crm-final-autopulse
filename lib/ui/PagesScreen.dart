// ignore_for_file: deprecated_member_use
import 'package:autopulse/resources/colors.dart';
import 'package:autopulse/ui/ChatScreen.dart';
import 'package:autopulse/ui/Homescreen.dart';
import 'package:autopulse/ui/MapScreen.dart';
import 'package:autopulse/ui/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PagesScreen extends StatefulWidget {
  const PagesScreen({super.key});

  @override
  State<PagesScreen> createState() => _MyNavState();
}

class _MyNavState extends State<PagesScreen> {
  int currentIndex = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const MapScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        type: BottomNavigationBarType.fixed, // Ensure fixed type
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xFF1463FF), // Active item color
        unselectedItemColor:
            const Color(0xFF9499A1).withOpacity(0.80), // Inactive item color
        selectedLabelStyle:
            const TextStyle(color: Color(0xFF1463FF)), // Active label style
        unselectedLabelStyle: TextStyle(
            color: const Color(0xFF9499A1)
                .withOpacity(0.80)), // Inactive label style
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "",
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SvgPicture.asset(
                'assets/bottom-nav-icons/active/Home.svg',
                color: const Color(0xFF1463FF), // Active icon color
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SvgPicture.asset(
                'assets/bottom-nav-icons/in-active/Home.svg',
                color: const Color(0xFF9499A1)
                    .withOpacity(0.80), // Inactive icon color
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SvgPicture.asset(
                'assets/bottom-nav-icons/active/map.svg',
                color: const Color(0xFF1463FF), // Active icon color
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SvgPicture.asset(
                'assets/bottom-nav-icons/in-active/map.svg',
                color: const Color(0xFF9499A1)
                    .withOpacity(0.80), // Inactive icon color
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SvgPicture.asset(
                'assets/bottom-nav-icons/active/chat.svg',
                color: const Color(0xFF1463FF), // Active icon color
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SvgPicture.asset(
                'assets/bottom-nav-icons/in-active/chat.svg',
                color: const Color(0xFF9499A1)
                    .withOpacity(0.80), // Inactive icon color
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SvgPicture.asset(
                'assets/bottom-nav-icons/active/profile.svg',
                color: const Color(0xFF1463FF), // Active icon color
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SvgPicture.asset(
                'assets/bottom-nav-icons/in-active/profile.svg',
                color: const Color(0xFF9499A1)
                    .withOpacity(0.80), // Inactive icon color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
