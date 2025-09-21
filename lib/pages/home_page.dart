import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/size.dart';
import 'package:my_portfolio/constants/skill_items.dart';
import 'package:my_portfolio/widgets/drawer_mobil.dart';
import 'package:my_portfolio/widgets/header_for_mobil.dart';
import 'package:my_portfolio/widgets/header_for_website.dart';
import 'package:my_portfolio/widgets/main_mobile_view.dart';
import 'package:my_portfolio/widgets/main_website_view.dart';
import 'package:my_portfolio/widgets/skills_website_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: CustomColor.scaffoldBg,
          endDrawer: constraints.maxWidth > smallScreenWidth
              ? null
              : DrawerMobile(),
          body: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Builder(
                builder: (context) {
                  if (constraints.maxWidth > smallScreenWidth) {
                    return HeaderForWebsite();
                  } else {
                    return HeaderForMobile(
                      onLogoTap: () {},
                      onMenuTap: () {
                        Scaffold.of(context).openEndDrawer();
                        log("Menu Tapped");
                      },
                    );
                  }
                },
              ),
              constraints.maxWidth > smallScreenWidth
                  ? MainWebsiteView()
                  : MainMobileView(),
              Container(
                width: screenWidth,
                padding: EdgeInsets.fromLTRB(25, 20, 25, 60),
                color: CustomColor.bgLight1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "What I can do",
                      style: TextStyle(
                        fontSize: 22,
                        color: CustomColor.whitePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 50),
                    SkillsWebsiteView(),
                  ],
                ),
              ),
              Container(height: 500, color: Colors.blueGrey),
              Container(height: 500, color: Colors.blueGrey),
              Container(height: 100, color: Colors.blueGrey),
            ],
          ),
        );
      },
    );
  }
}
