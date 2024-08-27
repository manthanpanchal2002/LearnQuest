import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart' as get_navigation;
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_quest/bloc/app_bloc.dart';
import 'package:learn_quest/bloc/app_event.dart';
import 'package:learn_quest/bloc/app_state.dart';
import 'package:learn_quest/screens/homeScreen.dart';
import 'package:learn_quest/screens/signUpScreen.dart';
import 'package:learn_quest/services/toast_service.dart';
import 'package:learn_quest/utils/colors.dart';
import 'package:learn_quest/utils/fonts.dart';

class Signinscreen extends StatefulWidget {
  const Signinscreen({Key? key}) : super(key: key);

  @override
  State<Signinscreen> createState() => _SigninscreenState();
}

class _SigninscreenState extends State<Signinscreen> {
  @override
  Widget build(BuildContext context) {
    // Get screen size and pixel ratio
    final size = MediaQuery.of(context).size;
    // Calculate a base unit for sizing
    final baseUnit = size.width / 100;

    return Scaffold(
      backgroundColor: appColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: baseUnit * 4, right: baseUnit * 4, top: baseUnit * 4),
          child: SingleChildScrollView(
            child: BlocProvider(
              create: (context) => LoginBloc(),
              child: LoginUser(),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginUser extends StatefulWidget {
  const LoginUser({
    super.key,
  });

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  // regex
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  RegExp passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

  // Form controller
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get screen size and pixel ratio
    final size = MediaQuery.of(context).size;
    // Calculate a base unit for sizing
    final baseUnit = size.width / 100;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccess) {
          // Navigate user to home screen
          Get.off(
            () => Homescreen(),
            transition: get_navigation.Transition.rightToLeft,
            duration: const Duration(milliseconds: 300),
          );
          // reset the fields
          _formKey.currentState!.reset();
        } else if (state is LoginFailure) {
          // show error toast
          ToastService.showErrorToast(context, state.msg);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sign In",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: appFont.body_fs,
                  fontWeight: FontWeight.w500,
                  color: appColors.black,
                ),
              ),
            ),
            SizedBox(
              height: baseUnit * 1.5,
            ),
            Text(
              "Almost done! Enter your email and password to dive into your learning journey!",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: appFont.sub_body_fs,
                  fontWeight: FontWeight.w500,
                  color: appColors.black.withOpacity(0.5),
                ),
              ),
            ),
            SizedBox(
              height: baseUnit * 7.6,
            ),
            TextFormField(
              controller: _emailController,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: appFont.body_fs,
                  fontWeight: FontWeight.w400,
                  color: appColors.black,
                ),
              ),
              autofocus: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(baseUnit * 4),
                labelText: "Email",
                labelStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: appFont.body_fs,
                    fontWeight: FontWeight.w400,
                    color: appColors.black,
                  ),
                ),
                hintText: "example@gmail.com",
                hintStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: appFont.body_fs,
                    fontWeight: FontWeight.w400,
                    color: appColors.black.withOpacity(0.5),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(baseUnit * 2),
                  borderSide: BorderSide(
                    color: appColors.black.withOpacity(0.5),
                    width: 0.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(baseUnit * 2),
                  borderSide: BorderSide(
                    color: appColors.black.withOpacity(0.5),
                    width: 0.5,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                } else if (!emailRegex.hasMatch(value)) {
                  return 'Invalid email';
                }
                return null;
              },
            ),
            SizedBox(
              height: baseUnit * 3,
            ),
            TextFormField(
              controller: _passwordController,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: appFont.body_fs,
                  fontWeight: FontWeight.w400,
                  color: appColors.black,
                ),
              ),
              autofocus: true,
              obscureText: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(baseUnit * 4),
                labelText: "Password",
                labelStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: appFont.body_fs,
                    fontWeight: FontWeight.w400,
                    color: appColors.black,
                  ),
                ),
                hintText: "********",
                hintStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: appFont.body_fs,
                    fontWeight: FontWeight.w400,
                    color: appColors.black.withOpacity(0.5),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(baseUnit * 2),
                  borderSide: BorderSide(
                    color: appColors.black.withOpacity(0.5),
                    width: 0.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(baseUnit * 2),
                  borderSide: BorderSide(
                    color: appColors.black.withOpacity(0.5),
                    width: 0.5,
                  ),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Password is required.";
                } else if (value.length < 8) {
                  return "Password is too short.";
                } else if (!passwordRegex.hasMatch(value)) {
                  return "Password must have minimun one lowercase,\nUPPERCASE, Special character and numeric value.";
                }

                return null;
              },
            ),
            SizedBox(
              height: baseUnit * 4.5,
            ),
            SizedBox(
              width: double.infinity,
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return TextButton(
                    style: ButtonStyle(
                      overlayColor: WidgetStateProperty.all<Color>(
                        Colors.transparent,
                      ),
                      minimumSize: WidgetStateProperty.all<Size>(
                        Size.fromHeight(baseUnit * 14.5),
                      ),
                      backgroundColor: WidgetStateProperty.all<Color>(
                        state is LoginLoading
                            ? appColors.honoluluBlue.withOpacity(0.1)
                            : appColors.honoluluBlue,
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(baseUnit * 2.5),
                        ),
                      ),
                    ),
                    onPressed: state is LoginLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginBloc>().add(
                                    LoginSubmitted(
                                      email:
                                          _emailController.text.toLowerCase(),
                                      password: _passwordController.text,
                                    ),
                                  );
                            }
                          },
                    child: state is LoginLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: baseUnit * 3.5,
                                width: baseUnit * 3.5,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  backgroundColor:
                                      appColors.honoluluBlue.withOpacity(0.01),
                                  color: appColors.honoluluBlue,
                                ),
                              ),
                              SizedBox(
                                width: baseUnit * 3,
                              ),
                              Text(
                                "Verifing",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: appFont.body_fs,
                                    fontWeight: FontWeight.w500,
                                    color: appColors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Text(
                            "Sign In",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: appFont.body_fs,
                                fontWeight: FontWeight.w500,
                                color: appColors.white,
                              ),
                            ),
                          ),
                  );
                },
              ),
            ),
            SizedBox(
              height: baseUnit * 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Are you new?",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: appFont.sub_body_fs,
                      fontWeight: FontWeight.w500,
                      color: appColors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: baseUnit * 1.5,
                ),
                InkWell(
                  overlayColor: WidgetStateProperty.all<Color>(
                    Colors.transparent,
                  ),
                  onTap: () {
                    Get.to(
                      () => Signupscreen(),
                      transition: get_navigation.Transition.downToUp,
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                  child: Text(
                    "Create an account",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: appFont.sub_body_fs,
                        fontWeight: FontWeight.w500,
                        color: appColors.honoluluBlue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
