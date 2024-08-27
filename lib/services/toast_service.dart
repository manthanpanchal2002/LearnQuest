import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_quest/utils/colors.dart';
import 'package:learn_quest/utils/fonts.dart';
import 'package:remixicon/remixicon.dart';

class ToastService {
  static void showToast(BuildContext context, String message,
      {bool isError = false}) {
    // Get screen size and pixel ratio
    final size = MediaQuery.of(context).size;
    // Calculate a base unit for sizing
    final baseUnit = size.width / 100;

    FToast fToast = FToast();
    fToast.init(context);
    Widget toast = Container(
      padding: EdgeInsets.symmetric(
          horizontal: baseUnit * 7, vertical: baseUnit * 3),
      decoration: BoxDecoration(
        color: appColors.black,
        borderRadius: BorderRadius.circular(baseUnit * 2),
        boxShadow: [
          BoxShadow(
            color: appColors.black.withOpacity(0.3),
            spreadRadius: 0.1,
            blurRadius: 8,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Remix.error_warning_line,
            size: baseUnit * 3.8,
            color: appColors.white,
          ),
          SizedBox(
            width: baseUnit * 1.5,
          ),
          Flexible(
            child: Text(
              message,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: appFont.sub_body_fs,
                  fontWeight: FontWeight.w500,
                  color: appColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 3),
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void showErrorToast(BuildContext context, String message) {
    showToast(context, message, isError: true);
  }
}
