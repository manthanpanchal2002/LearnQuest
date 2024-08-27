import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart' as get_navigation;
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_quest/bloc/app_bloc.dart';
import 'package:learn_quest/bloc/app_event.dart';
import 'package:learn_quest/bloc/app_state.dart';
import 'package:learn_quest/dataModels/coursesModel.dart';
import 'package:learn_quest/dataModels/sharedPreferrencedData.dart';
import 'package:learn_quest/screens/searchScreen.dart';
import 'package:learn_quest/screens/siginInScreen.dart';
import 'package:learn_quest/utils/colors.dart';
import 'package:learn_quest/utils/fonts.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  // Get user details
  Future<void> getUserProfileChar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    sharedPreferencedData.userProfileChar = prefs.getString('userProfileChar');
    sharedPreferencedData.userEmail = prefs.getString('userEmail');
    sharedPreferencedData.userFirstName = prefs.getString('userFirstName');
    sharedPreferencedData.userLastName = prefs.getString('userLastName');
    if (mounted) {
      setState(() {});
    }
  }

  // Log-out user
  logOutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userProfileChar');
    prefs.remove('userEmail');
    prefs.remove('userFirstName');
    prefs.remove('userLastName');
    prefs.remove('userAccessToken');
    prefs.remove('accessTokenType');
  }

  @override
  void initState() {
    super.initState();
    getUserProfileChar();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size and pixel ratio
    final size = MediaQuery.of(context).size;
    // Calculate a base unit for sizing
    final baseUnit = size.width / 100;

    return Scaffold(
      backgroundColor: appColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => CoursesBloc()..add(FetchCourses()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: baseUnit * 4,
                      right: baseUnit * 4,
                      top: baseUnit * 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          InkWell(
                            overlayColor:
                                WidgetStateProperty.all(Colors.transparent),
                            onTap: () {
                              Get.to(
                                () => Searchscreen(),
                                transition: get_navigation.Transition.downToUp,
                                duration: const Duration(milliseconds: 300),
                              );
                            },
                            child: Icon(
                              Remix.search_2_line,
                              size: baseUnit * 6,
                              color: appColors.black.withOpacity(0.18),
                            ),
                          ),
                          SizedBox(
                            width: baseUnit * 4.5,
                          ),
                          sharedPreferencedData.userProfileChar != null
                              ? InkWell(
                                  overlayColor: WidgetStateProperty.all(
                                      Colors.transparent),
                                  onTap: () {
                                    showModalBottomSheet(
                                      showDragHandle: true,
                                      backgroundColor: appColors.white,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: baseUnit * 60,
                                          color: appColors.white,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                leading: Container(
                                                  height: baseUnit * 12,
                                                  width: baseUnit * 12,
                                                  decoration: BoxDecoration(
                                                    color: appColors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0,
                                                            vertical:
                                                                baseUnit * 2.0),
                                                    child: Text(
                                                      sharedPreferencedData
                                                          .userProfileChar
                                                          .toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize:
                                                            appFont.subtitle_fs,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: appColors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                title: Text(
                                                    "${sharedPreferencedData.userFirstName} ${sharedPreferencedData.userLastName}"),
                                                titleTextStyle:
                                                    GoogleFonts.poppins(
                                                  fontSize: appFont.body_fs,
                                                  fontWeight: FontWeight.w500,
                                                  color: appColors.black,
                                                ),
                                                subtitle: Text(
                                                    sharedPreferencedData
                                                        .userEmail
                                                        .toString()),
                                                subtitleTextStyle:
                                                    GoogleFonts.poppins(
                                                  fontSize: appFont.sub_body_fs,
                                                  fontWeight: FontWeight.w500,
                                                  color: appColors.black
                                                      .withOpacity(0.2),
                                                ),
                                                trailing: InkWell(
                                                  overlayColor:
                                                      WidgetStateProperty.all(
                                                          Colors.transparent),
                                                  onTap: () {},
                                                  child: Icon(
                                                    Remix.edit_line,
                                                    size: baseUnit * 5,
                                                    color: appColors.black
                                                        .withOpacity(0.15),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: baseUnit * 3,
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          baseUnit * 4.5,
                                                      vertical: 0),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          baseUnit *
                                                                              3),
                                                            ),
                                                            backgroundColor:
                                                                appColors.white,
                                                            title: Text(
                                                              "Do you want to Log out?",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                textStyle:
                                                                    TextStyle(
                                                                  fontSize: appFont
                                                                      .body_fs,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      appColors
                                                                          .black,
                                                                ),
                                                              ),
                                                            ),
                                                            content: Container(
                                                              height: baseUnit *
                                                                  1.5,
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  overlayColor:
                                                                      appColors
                                                                          .white,
                                                                ),
                                                                child: Text(
                                                                  "No",
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    textStyle:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          appFont
                                                                              .sub_body_fs,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: appColors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  logOutUser();
                                                                  Navigator
                                                                      .pushAndRemoveUntil(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              Signinscreen(),
                                                                    ),
                                                                    (Route<dynamic>
                                                                            route) =>
                                                                        false,
                                                                  );
                                                                },
                                                                style:
                                                                    ButtonStyle(
                                                                  overlayColor:
                                                                      WidgetStateProperty
                                                                          .all<
                                                                              Color>(
                                                                    Colors
                                                                        .transparent,
                                                                  ),
                                                                  minimumSize:
                                                                      WidgetStateProperty
                                                                          .all<
                                                                              Size>(
                                                                    Size(
                                                                        baseUnit *
                                                                            14.5,
                                                                        baseUnit *
                                                                            3),
                                                                  ),
                                                                  backgroundColor: WidgetStateProperty.all<
                                                                          Color>(
                                                                      appColors
                                                                          .black),
                                                                  shape: WidgetStateProperty
                                                                      .all<
                                                                          RoundedRectangleBorder>(
                                                                    RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(baseUnit *
                                                                              15),
                                                                    ),
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  "Yes",
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    textStyle:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          appFont
                                                                              .sub_body_fs,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: appColors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    style: ButtonStyle(
                                                      overlayColor:
                                                          WidgetStateProperty
                                                              .all<Color>(
                                                        Colors.transparent,
                                                      ),
                                                      minimumSize:
                                                          WidgetStateProperty
                                                              .all<Size>(
                                                        Size.fromHeight(
                                                            baseUnit * 14.5),
                                                      ),
                                                      backgroundColor:
                                                          WidgetStateProperty
                                                              .all<Color>(
                                                        appColors.textErrorRed
                                                            .withOpacity(0.1),
                                                      ),
                                                      shape: WidgetStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      baseUnit *
                                                                          2),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Remix.logout_box_line,
                                                          color: appColors
                                                              .textErrorRed,
                                                          size: baseUnit * 4.5,
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          "Log out",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                TextStyle(
                                                              fontSize: appFont
                                                                  .body_fs,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: appColors
                                                                  .textErrorRed,
                                                            ),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: baseUnit * 6,
                                    width: baseUnit * 6,
                                    decoration: BoxDecoration(
                                      color: appColors.black,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 0,
                                          vertical: baseUnit * 0.8),
                                      child: Text(
                                        sharedPreferencedData.userProfileChar
                                            .toString(),
                                        style: GoogleFonts.poppins(
                                          fontSize: appFont.sub_body_fs,
                                          fontWeight: FontWeight.w600,
                                          color: appColors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  overlayColor: WidgetStateProperty.all(
                                      Colors.transparent),
                                  onTap: () {
                                    Get.off(
                                      () => Signinscreen(),
                                      transition:
                                          get_navigation.Transition.downToUp,
                                      duration:
                                          const Duration(milliseconds: 300),
                                    );
                                  },
                                  child: Icon(
                                    Remix.account_circle_line,
                                    size: baseUnit * 6,
                                    color: appColors.black,
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(
                        height: baseUnit * 6,
                      ),
                      Text(
                        "let's learn",
                        style: GoogleFonts.poppins(
                          fontSize: appFont.title_fs,
                          fontWeight: FontWeight.w400,
                          color: appColors.black.withOpacity(0.15),
                        ),
                      ),
                      Text(
                        "Something new!",
                        style: GoogleFonts.poppins(
                          fontSize: appFont.title_fs,
                          fontWeight: FontWeight.w700,
                          color: appColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: baseUnit * 6,
                ),
                const CoursesData(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Courses data class
class CoursesData extends StatefulWidget {
  const CoursesData({super.key});

  @override
  State<CoursesData> createState() => _CoursesDataState();
}

class _CoursesDataState extends State<CoursesData> {
  @override
  Widget build(BuildContext context) {
    // Get screen size and pixel ratio
    final size = MediaQuery.of(context).size;
    // Calculate a base unit for sizing
    final baseUnit = size.width / 100;

    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        if (state is InitialState || state is LoadingState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: baseUnit * 1.8,
                width: baseUnit * 1.8,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  backgroundColor: appColors.honoluluBlue.withOpacity(0.01),
                  color: appColors.black.withOpacity(0.2),
                ),
              ),
              SizedBox(
                width: baseUnit * 1.5,
              ),
              Text(
                "Loading",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: appFont.sub_body_fs,
                    fontWeight: FontWeight.w400,
                    color: appColors.black.withOpacity(0.2),
                  ),
                ),
              ),
            ],
          );
        } else if (state is SuccessState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: baseUnit * 4,
                    left: baseUnit * 4,
                    bottom: baseUnit * 1.1),
                child: Row(
                  children: [
                    Text(
                      "Top courses",
                      style: GoogleFonts.poppins(
                        fontSize: appFont.subtitle_fs,
                        fontWeight: FontWeight.w700,
                        color: appColors.honoluluBlue,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "See more",
                      style: GoogleFonts.poppins(
                        fontSize: appFont.sub_body_fs,
                        fontWeight: FontWeight.w500,
                        color: appColors.black.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        right: baseUnit * 4,
                        left: baseUnit * 4,
                        top: baseUnit * 1.9,
                        bottom: baseUnit * 3.0,
                      ),
                      child: topCoursesCard(context, state.courses[index]),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 0);
                  },
                  itemCount: 3),
              SizedBox(
                height: baseUnit * 2.5,
              ),
            ],
          );
        } else if (state is ErrorState) {
          return Center(
            child: Text(
              state.msg,
              style: GoogleFonts.poppins(
                fontSize: appFont.sub_body_fs,
                fontWeight: FontWeight.w400,
                color: appColors.black.withOpacity(0.2),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

// Top courses cards
Widget topCoursesCard(BuildContext context, CoursesModel course) {
  // Get screen size and pixel ratio
  final size = MediaQuery.of(context).size;
  // Calculate a base unit for sizing
  final baseUnit = size.width / 100;

  return Container(
    height: baseUnit * 63,
    decoration: BoxDecoration(
      color: appColors.white,
      borderRadius: BorderRadius.circular(baseUnit * 2.8),
      boxShadow: [
        BoxShadow(
          color: appColors.darkGrey.withOpacity(0.1),
          spreadRadius: 0.1,
          blurRadius: 8,
          offset: const Offset(0, 0),
        ),
      ],
    ),
    child: Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: baseUnit * 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(baseUnit * 2.8),
                  topRight: Radius.circular(baseUnit * 2.8)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(baseUnit * 2.8),
                  topRight: Radius.circular(baseUnit * 2.8)),
              child: Image.network(
                course.courseImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: baseUnit * 40,
          left: baseUnit * 2.5,
          right: baseUnit * 2.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.maxFinite,
                height: baseUnit * 11.5,
                child: Text(
                  course.courseName.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: appFont.body_fs,
                    fontWeight: FontWeight.w600,
                    color: appColors.black,
                  ),
                ),
              ),
              SizedBox(
                height: baseUnit * 1.5,
              ),
              Row(
                children: [
                  Text(
                    "Just for ₹${course.coursePrice.toInt()}",
                    style: GoogleFonts.poppins(
                      fontSize: appFont.sub_body_fs,
                      fontWeight: FontWeight.w500,
                      color: appColors.black.withOpacity(0.25),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: baseUnit * 7.5,
                    width: baseUnit * 25,
                    decoration: BoxDecoration(
                      color: appColors.black.withOpacity(0.025),
                      borderRadius: BorderRadius.circular(baseUnit * 4.6),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: baseUnit * 1.9, vertical: baseUnit * 1.5),
                      child: Text(
                        "Enroll now",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: appFont.sub_body_fs,
                          fontWeight: FontWeight.w600,
                          color: appColors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
