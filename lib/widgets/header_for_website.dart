import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/nav_items.dart';
import 'package:my_portfolio/styles/style.dart';
import 'package:my_portfolio/widgets/site_logo.dart';

class HeaderForWebsite extends StatelessWidget {
  const HeaderForWebsite({super.key, required this.onNavItemTap});
  final Function(int) onNavItemTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.maxFinite,
      decoration: kHeaderDecoration,
      child: Row(
        children: [
          SiteLogo(onTap: () {}),
          Spacer(),
          for (var i = 0; i < navItems.length; i++)
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: TextButton(
                onPressed: () {
                  onNavItemTap(i);
                },
                child: Text(
                  navItems[i],
                  style: TextStyle(
                    fontSize: 16,
                    color: CustomColor.whitePrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
