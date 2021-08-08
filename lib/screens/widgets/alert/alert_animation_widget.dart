import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class AlertAnimationWidget extends StatelessWidget {
  final String animation;
  final String text;
  final Widget? action;
  const AlertAnimationWidget({
    required this.animation,
    required this.text,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            animation,
            width: 180.0,
            height: 180.0,
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            width: 200.0,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          action != null ? action! : SizedBox(),
        ],
      ),
    );
  }
}
