import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';

class MainWebsiteView extends StatelessWidget {
  const MainWebsiteView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: screenSize.height / 1.2,
      constraints: BoxConstraints(minHeight: 350),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hi,\nI'm Ahmed Hisham Rasmy\nA Flutter Developer",
                style: TextStyle(
                  fontSize: 25,
                  height: 1.5,
                  color: CustomColor.whitePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColor.yellowPrimary,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  ),
                  onPressed: () {},
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
          Image.asset(
            "assets/images/bgroundimage.png",
            width: screenWidth / 3.5,
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
