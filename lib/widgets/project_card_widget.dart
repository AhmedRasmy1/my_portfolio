import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/utils/project_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCardWidget extends StatelessWidget {
  const ProjectCardWidget({required this.project, super.key});

  final ProjectUtils project;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 290,
      width: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CustomColor.bgLight2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            project.image,
            height: 140,
            width: 260,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 15, 12, 12),
            child: Text(
              project.title,
              style: TextStyle(
                fontSize: 15,
                color: CustomColor.whitePrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Text(
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              project.subtitle,
              style: TextStyle(
                fontSize: 11,
                color: CustomColor.whiteSecondary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Spacer(),
          Container(
            color: CustomColor.bgLight1,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Text(
                  "Available on: ",
                  style: TextStyle(
                    fontSize: 12,
                    color: CustomColor.yellowSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () async {
                    final uri = Uri.parse(project.githubLink);
                    if (!await launchUrl(
                      uri,
                      mode: LaunchMode.platformDefault,
                    )) {
                      log('Could not launch $uri');
                    }
                    log("GitHub Tapped");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Image.asset(
                      "assets/images/GitHub_icon.png",
                      height: 20,
                      width: 18,
                      color: CustomColor.whitePrimary,
                    ),
                  ),
                ),
                if (project.androidLink != null &&
                    project.androidLink!.isNotEmpty)
                  InkWell(
                    onTap: () async {
                      final uri = Uri.parse(project.androidLink!);
                      if (!await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      )) {
                        log('Could not launch $uri');
                      }
                      log("Android Tapped");
                    },
                    child: Image.asset(
                      "assets/images/android_icon.png",
                      height: 20,
                      width: 20,
                      color: CustomColor.whitePrimary,
                    ),
                  )
                else
                  InkWell(
                    onTap: () {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: "Coming Soon",
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const SizedBox.shrink();
                        },
                        transitionBuilder:
                            (context, animation, secondaryAnimation, child) {
                              return ScaleTransition(
                                scale: CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOutBack,
                                ),
                                child: AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  backgroundColor: CustomColor.bgLight2,
                                  title: const Text(
                                    "Coming soon...",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  content: const Text(
                                    "This app will be available on Android soon.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              );
                            },
                      );
                    },
                    child: Image.asset(
                      "assets/images/android_icon.png",
                      height: 20,
                      width: 20,
                      color: CustomColor.whiteSecondary,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
