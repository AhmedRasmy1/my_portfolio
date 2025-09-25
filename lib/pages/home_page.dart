import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/nav_items.dart';
import 'package:my_portfolio/constants/size.dart';
import 'package:my_portfolio/widgets/contact_widget.dart';
import 'package:my_portfolio/widgets/drawer_mobil.dart';
import 'package:my_portfolio/widgets/fotter_widget.dart';
import 'package:my_portfolio/widgets/header_for_mobil.dart';
import 'package:my_portfolio/widgets/header_for_website.dart';
import 'package:my_portfolio/widgets/main_mobile_view.dart';
import 'package:my_portfolio/widgets/main_website_view.dart';
import 'package:my_portfolio/widgets/projects.dart';
import 'package:my_portfolio/widgets/skills_website_view.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> navBarKeys = List.generate(
    navItems.length,
    (index) => GlobalKey(),
  );

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
              : DrawerMobile(
                  onNavItemTap: (index) {
                    scrollToSection(index);
                    Navigator.of(context).pop();
                  },
                ),
          body: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Builder(
                  builder: (context) {
                    SizedBox(key: navBarKeys.first);
                    if (constraints.maxWidth > smallScreenWidth) {
                      return HeaderForWebsite(
                        onNavItemTap: (index) {
                          scrollToSection(index);
                        },
                      );
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
                  key: navBarKeys[1],
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
                Container(
                  key: navBarKeys[2],
                  width: screenWidth,
                  padding: EdgeInsets.fromLTRB(25, 20, 25, 60),
                  child: Column(
                    children: [
                      Text(
                        "Work Projects",
                        style: TextStyle(
                          fontSize: 22,
                          color: CustomColor.whitePrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 50),
                      Projectss(),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                ContactWidget(key: navBarKeys[3]),
                FooterWidget(),
              ],
            ),
          ),
        );
      },
    );
  }

  void scrollToSection(int index) async {
    if (index == 4) {
      final uri = Uri.parse(
        "https://drive.google.com/file/d/11YrYHew_XfhvkSrL7yXv0N_tln-5BJmz/view?usp=drive_link",
      );
      if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
        log('Could not launch $uri');
        return;
      }
    }
    final keyContext = navBarKeys[index].currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}
