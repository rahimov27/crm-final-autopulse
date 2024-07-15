import 'package:autopulse/resources/colors.dart';
import 'package:autopulse/resources/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      "Profile",
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Row(
                children: [
                  const SizedBox(
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/profile_icons/avatar.png'),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jon Jones",
                          style: AppFonts.profileTitleName,
                        ),
                        Text(
                          "+1-212-456-7890",
                          style: AppFonts.profileSubTitleName,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: AppColors.widgetsColors,
                          title: const Text(
                            "Scan",
                            style: AppFonts.appBarText,
                          ),
                          icon: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ),
                      );
                    },
                    child: SvgPicture.asset('assets/profile_icons/qr.svg'),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9491,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.widgetsColors,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ProfileRow(
                          title: "Account",
                          image: "assets/profile_icons/user.svg",
                        ),
                        ProfileRow(
                          title: "Documents",
                          image: "assets/profile_icons/documents.svg",
                        ),
                        ProfileRow(
                          title: "Documents sign",
                          image: "assets/profile_icons/doc-sign.svg",
                        ),
                        ProfileRow(
                          title: "Help",
                          image: "assets/profile_icons/help.svg",
                        ),
                        ProfileRow(
                          title: "Settings",
                          image: "assets/profile_icons/settings.svg",
                        ),
                        ProfileRow(
                          title: "Notifications",
                          image: "assets/profile_icons/notif.svg",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9491,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.widgetsColors,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ProfileRow(
                          title: "Delete Account",
                          image: "assets/profile_icons/user.svg",
                        ),
                        ProfileRow(
                          title: "Logout",
                          image: "assets/profile_icons/logout.svg",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileRow extends StatelessWidget {
  const ProfileRow({
    super.key,
    required this.title,
    required this.image,
  });
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: AppColors.widgetsColors,
            title: Text(
              title,
              style: AppFonts.widgetTitle,
            ),
            content: const Text(
              "This is a centered dialog.",
              style: AppFonts.chatText,
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close),
              ),
            ],
          ),
        );
      },
      child: Row(
        children: [
          ClipRRect(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.profileIconColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SvgPicture.asset(image),
                ),
              ),
            ),
          ),
          Text(
            title,
            style: AppFonts.chatText,
          ),
          const Spacer(),
          SvgPicture.asset('assets/profile_icons/arrow-right.svg'),
        ],
      ),
    );
  }
}
