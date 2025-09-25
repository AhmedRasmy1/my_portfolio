import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/nav_items.dart';

class DrawerMobile extends StatelessWidget {
  const DrawerMobile({super.key, required this.onNavItemTap});
  final Function(int) onNavItemTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: CustomColor.scaffoldBg,
      child: ListView(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close),
              ),
            ),
          ),
          for (var i = 0; i < navIcons.length; i++)
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              titleTextStyle: TextStyle(
                color: CustomColor.whitePrimary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              leading: Icon(navIcons[i]),
              title: Text(navItems[i]),
              onTap: () {
                onNavItemTap(i);
                // Navigator.of(context).pop();
              },
            ),
        ],
      ),
    );
  }
}
