import 'dart:developer';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/project_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCardWidget extends StatefulWidget {
  const ProjectCardWidget({required this.project, super.key});
  final ProjectUtils project;

  @override
  State<ProjectCardWidget> createState() => _ProjectCardWidgetState();
}

class _ProjectCardWidgetState extends State<ProjectCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.scale(scale: _scaleAnimation.value, child: child),
        );
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: 290,
        width: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: CustomColor.bgLight2,
          boxShadow: [
            BoxShadow(
              color: CustomColor.whiteSecondary.withOpacity(0.19),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: widget.project.image,
              child: Image.asset(
                widget.project.image,
                height: 140,
                width: 260,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 15, 12, 12),
              child: Text(
                widget.project.title,
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
                widget.project.subtitle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  color: CustomColor.whiteSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Spacer(),
            Container(
              color: CustomColor.bgLight1,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                  const Spacer(),
                  InkWell(
                    onTap: () async {
                      final uri = Uri.parse(widget.project.githubLink);
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
                  if (widget.project.androidLink != null &&
                      widget.project.androidLink!.isNotEmpty)
                    InkWell(
                      onTap: () async {
                        final uri = Uri.parse(widget.project.androidLink!);
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
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
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
      ),
    );
  }
}
