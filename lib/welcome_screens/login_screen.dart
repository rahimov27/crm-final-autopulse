import 'package:autopulse/auth/firebase_services.dart';
import 'package:autopulse/resources/fonts.dart';
import 'package:autopulse/ui/PagesScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int groupValue = 0; // 0 for Login, 1 for Register
  bool isChecked = false;
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _resendPassword = TextEditingController();
  final TextEditingController _registerEmailController =
      TextEditingController();
  final TextEditingController _registerPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33),
          child: Column(
            children: [
              SvgPicture.asset('assets/logo.svg', width: 60),
              Text("Autopulse", style: AppFonts.loginTitle),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: SizedBox(
                  width: 240,
                  child: Text(
                    "Create an account or log in to explore our app",
                    textAlign: TextAlign.center,
                    style: AppFonts.loginSubTitle,
                  ),
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: CupertinoSlidingSegmentedControl<int>(
                  backgroundColor: Color(0xffF5F6F9),
                  padding: EdgeInsets.all(5),
                  groupValue: groupValue,
                  children: {
                    0: Text("Log In",
                        style: AppFonts.chatText
                            .copyWith(color: Colors.black, fontSize: 14)),
                    1: Text("Register",
                        style: AppFonts.chatText
                            .copyWith(color: Colors.black, fontSize: 14)),
                  },
                  onValueChanged: (value) =>
                      setState(() => groupValue = value ?? 0),
                ),
              ),
              if (groupValue == 0) ...[
                _buildLoginForm(),
              ] else if (groupValue == 1) ...[
                _buildRegisterForm(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: TextFieldLogin(
            controller: _emailController,
            textFieldTitle: "Email",
            hintTextField: "example@gmail.com",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: TextFieldPassword(
            controller: _passwordController,
            textFieldTitle: "Password",
            hintTextField: "Password",
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 24,
              child: Checkbox(
                value: isChecked,
                activeColor: Colors.grey,
                checkColor: Colors.white,
                onChanged: (value) =>
                    setState(() => isChecked = value ?? false),
              ),
            ),
            Text("Remember me", style: AppFonts.loginTextFieldTitle),
            Spacer(),
            TextButton(
              onPressed: () => _showResetPasswordDialog(),
              child: Text("Forgot password?",
                  style: AppFonts.loginTextFieldTitle
                      .copyWith(color: Colors.blue)),
            ),
          ],
        ),
        SizedBox(height: 24),
        SizedBox(
          height: 48,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff1D61E7),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: _isLoading ? null : _login,
            child: _isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : Text("Log In",
                    style: AppFonts.loginTextFieldTitle.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
          ),
        ),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account?", style: AppFonts.loginTextFieldTitle),
            TextButton(
              onPressed: () => setState(() => groupValue = 1),
              child: Text("Sign up",
                  style: AppFonts.loginTextFieldTitle
                      .copyWith(color: Colors.blue)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRegisterForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: TextFieldLogin(
            controller: _registerEmailController,
            textFieldTitle: "Email",
            hintTextField: "example@gmail.com",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: TextFieldPassword(
            controller: _registerPasswordController,
            textFieldTitle: "Password",
            hintTextField: "Password",
          ),
        ),
        SizedBox(height: 24),
        SizedBox(
          height: 48,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff1D61E7),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: _isLoading ? null : _register,
            child: _isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : Text("Register",
                    style: AppFonts.loginTextFieldTitle.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
          ),
        ),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account?",
                style: AppFonts.loginTextFieldTitle),
            TextButton(
              onPressed: () => setState(() => groupValue = 0),
              child: Text("Log In",
                  style: AppFonts.loginTextFieldTitle
                      .copyWith(color: Colors.blue)),
            ),
          ],
        ),
      ],
    );
  }

  void _showResetPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: SizedBox(
          height: 150,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldLogin(
                  controller: _resendPassword,
                  textFieldTitle: "Reset password by email",
                  hintTextField: "Enter email",
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1D61E7),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: _resetPassword,
                      child: Text("Reset password",
                          style: AppFonts.loginTextFieldTitle.copyWith(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    bool isAuthorized = await FirebaseServices().authByEmail(
      email: _emailController.text,
      password: _passwordController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (isAuthorized) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const PagesScreen()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Incorrect email or password')));
    }
  }

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });
    bool isRegistered = await FirebaseServices().registerByEmail(
      email: _registerEmailController.text,
      password: _registerPasswordController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (isRegistered) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const PagesScreen()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Registration failed')));
    }
  }

  Future<void> _resetPassword() async {
    bool isAuth =
        await FirebaseServices().resendPassword(email: _resendPassword.text);
    if (isAuth) {
      Navigator.pop(context);
    } else {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("Error"),
            content: Text("Please enter a valid email"),
            actions: [
              CupertinoDialogAction(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      _resendPassword.text = "";
    }
  }
}

class socialContainer extends StatelessWidget {
  const socialContainer({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Color(0xffEDF1F3),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: SvgPicture.asset(imagePath),
      ),
    );
  }
}

class TextFieldLogin extends StatelessWidget {
  const TextFieldLogin(
      {super.key,
      required this.textFieldTitle,
      required this.hintTextField,
      required this.controller});

  final TextEditingController controller;
  final String textFieldTitle;
  final String hintTextField;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textFieldTitle,
          style: AppFonts.loginTextFieldTitle,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: TextField(
            controller: controller,
            cursorColor: Color.fromARGB(255, 173, 173, 173),
            cursorWidth: 1.5,
            cursorHeight: 20,
            style: AppFonts.loginTextFieldTitle.copyWith(color: Colors.black),
            decoration: InputDecoration(
              hintText: hintTextField,
              hintStyle: AppFonts.loginTextFieldTitle,
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Color(0xffEDF1F3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 227, 227, 227),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TextFieldPassword extends StatefulWidget {
  const TextFieldPassword({
    super.key,
    required this.textFieldTitle,
    required this.hintTextField,
    required this.controller,
  });

  final TextEditingController controller;
  final String textFieldTitle;
  final String hintTextField;

  @override
  _TextFieldPasswordState createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextFieldPassword> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.textFieldTitle,
          style: AppFonts.loginTextFieldTitle,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: TextField(
            controller: widget.controller,
            obscureText: _obscureText,
            cursorColor: Color.fromARGB(255, 173, 173, 173),
            cursorWidth: 1.5,
            cursorHeight: 20,
            style: AppFonts.loginTextFieldTitle.copyWith(color: Colors.black),
            decoration: InputDecoration(
              hintText: widget.hintTextField,
              hintStyle: AppFonts.loginTextFieldTitle,
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Color(0xffEDF1F3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 227, 227, 227),
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Color.fromARGB(255, 173, 173, 173),
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
