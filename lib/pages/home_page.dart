import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/size.dart';
import 'package:my_portfolio/widgets/drawer_mobil.dart';
import 'package:my_portfolio/widgets/header_for_mobil.dart';
import 'package:my_portfolio/widgets/header_for_website.dart';
import 'package:my_portfolio/widgets/main_website_view.dart';

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
              MainWebsiteView(),
              Container(height: 500, color: Colors.blueGrey),
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
