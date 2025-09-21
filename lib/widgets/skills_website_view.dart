import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/skill_items.dart';

class SkillsWebsiteView extends StatelessWidget {
  const SkillsWebsiteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 450),
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              for (var i = 0; i < platformsIcon.length; i++)
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: CustomColor.bgLight2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    leading: Image.asset(
                      platformsIcon[i]['icon']!,
                      width: 40,
                      height: 40,
                      color: CustomColor.whiteSecondary,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      platformsIcon[i]['name']!,
                      style: TextStyle(
                        color: CustomColor.whitePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(width: 50),
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (var i = 0; i < skillsIcon.length; i++)
                  Chip(
                    backgroundColor: CustomColor.bgLight2,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    avatar: Image.asset(
                      skillsIcon[i]['icon']!,
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                    label: Text(
                      skillsIcon[i]['name']!,
                      style: TextStyle(
                        color: CustomColor.whitePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
