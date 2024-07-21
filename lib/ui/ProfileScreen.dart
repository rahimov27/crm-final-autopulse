import 'dart:io';
import 'dart:math';

import 'package:autopulse/welcome_screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:autopulse/resources/colors.dart';
import 'package:autopulse/resources/fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  bool isFront = true;
  late AnimationController _controller;
  late Animation<double> _animation;
  File? _selectedImage;
  User? _user;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _loadImage();
    fetchUser();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      setState(() {
        _user = user;
      });
    } catch (e) {
      debugPrint('Error fetching user: ${e.toString()}');
    }
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imageFile = File(pickedFile.path);
        final imageName = pickedFile.name;

        final localImage = await imageFile.copy('${directory.path}/$imageName');

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('profile_image_path', localImage.path);

        if (mounted) {
          setState(() {
            _selectedImage = localImage;
          });
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No image selected')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }
  }

  Future<void> _loadImage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final imagePath = prefs.getString('profile_image_path');
      if (imagePath != null) {
        if (mounted) {
          setState(() {
            _selectedImage = File(imagePath);
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading image: $e')),
        );
      }
    }
  }

  Future<void> _removeImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image_path');

    if (imagePath != null) {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
      }
      await prefs.remove('profile_image_path');

      if (mounted) {
        setState(() {
          _selectedImage = null;
        });
      }
    }
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('profile_image_path');
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } catch (e) {
      debugPrint('Error signing out: ${e.toString()}');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error signing out: $e')),
        );
      }
    }
  }

  void _toggleCard() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      isFront = !isFront;
    });
  }

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
              const SizedBox(height: 30),
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: _pickImage,
                      child: CircleAvatar(
                        backgroundImage: _selectedImage != null
                            ? Image.file(_selectedImage!).image
                            : const AssetImage(
                                    'assets/profile_icons/avatar.png')
                                as ImageProvider,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _user?.email ?? "No email available",
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
                          content: Image.network(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/QR_Code_Example.svg/1200px-QR_Code_Example.svg.png",
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                    child: SvgPicture.asset('assets/profile_icons/qr.svg'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 40),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9491,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.widgetsColors,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ProfileRow(
                          title: "Account",
                          image: "assets/profile_icons/user.svg",
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: AppColors.widgetsColors,
                                title: Text(
                                  "Documents",
                                  style: AppFonts.widgetTitle
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                content: SizedBox(
                                  height: 250,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: _toggleCard,
                                        child: AnimatedBuilder(
                                          animation: _animation,
                                          builder: (context, child) {
                                            return Transform(
                                              alignment: Alignment.center,
                                              transform: Matrix4.rotationY(
                                                  _animation.value * pi),
                                              child: isFront
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image.network(
                                                        'https://upload.wikimedia.org/wikipedia/commons/7/79/Californian_sample_driver%27s_license%2C_c._2019.jpg',
                                                      ),
                                                    )
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image.network(
                                                        'https://gray-kold-prod.cdn.arcpublishing.com/resizer/k8boB8OCNmBT6NExyGMTy0IJ7YQ=/980x0/smart/filters:quality(85)/cloudfront-us-east-1.images.arcpublishing.com/gray/ICMHNY7DPJGORNXSNMQGJQXFWE.jpg',
                                                      ),
                                                    ),
                                            );
                                          },
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          overlayColor: Colors.black,
                                          backgroundColor:
                                              AppColors.appBarBackgroundColor,
                                          minimumSize:
                                              const Size(double.infinity, 50),
                                        ),
                                        child: Text(
                                          "Back",
                                          style: AppFonts.chatText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: ProfileRow(
                            title: "Documents",
                            image: "assets/profile_icons/documents.svg",
                          ),
                        ),
                        ProfileRow(
                          title: "Documents sign",
                          image: "assets/profile_icons/doc-sign.svg",
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor:
                                    AppColors.appBarBackgroundColor,
                                title: Text(
                                  "Help",
                                  style: AppFonts.widgetTitle,
                                ),
                                content: SizedBox(
                                  height: 250,
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Business Hours:\nMonday - Friday: 9:00 AM - 6:00 PM\nSaturday: 10:00 AM - 4:00 PM\nSunday: Closed",
                                        style: AppFonts.chatText,
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        "AutoPulse is dedicated to providing innovative solutions for automotive diagnostics and maintenance. Our state-of-the-art CRM system helps businesses manage customer relationships, streamline operations, and improve overall efficiency.",
                                        style: AppFonts.chatText,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: ProfileRow(
                            title: "Help",
                            image: "assets/profile_icons/help.svg",
                          ),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ProfileRow(
                          title: "Delete Account",
                          image: "assets/profile_icons/user.svg",
                        ),
                        InkWell(
                          onTap: _logout,
                          child: ProfileRow(
                            title: "Logout",
                            image: "assets/profile_icons/logout.svg",
                          ),
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
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
