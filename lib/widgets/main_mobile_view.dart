import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../pages/home_page.dart';

class MainMobileView extends StatelessWidget {
  const MainMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
      height: screenHeight,
      constraints: BoxConstraints(minHeight: 560),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: [
                  CustomColor.scaffoldBg.withOpacity(0.7),
                  CustomColor.scaffoldBg.withOpacity(0.7),
                ],
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: Image.asset(
              "assets/images/bgroundimage.png",
              width: screenWidth,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Hi,\nI'm Ahmed Hisham Rasmy\nA Flutter Developer",
            style: TextStyle(
              fontSize: 20,
              height: 1.5,
              color: CustomColor.whitePrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 250,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: CustomColor.yellowPrimary,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              ),
              onPressed: () {
                final homePageState = context
                    .findAncestorStateOfType<HomePageState>();
                homePageState?.scrollToSection(3);
              },
              child: Text(
                "GET IN TOUCH",
                style: TextStyle(
                  color: CustomColor.whitePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
