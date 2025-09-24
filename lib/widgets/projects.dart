import 'package:flutter/material.dart';
import 'package:my_portfolio/utils/project_utils.dart';
import 'package:my_portfolio/widgets/project_card_widget.dart';

class Projectss extends StatelessWidget {
  const Projectss({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 900),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: [
          for (int i = 0; i < projectList.length; i++)
            ProjectCardWidget(project: projectList[i]),
        ],
      ),
    );
  }
}
