import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/skill_items.dart';

class SkillsWebsiteView extends StatelessWidget {
  const SkillsWebsiteView({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: isMobile
              ? Column(
                  key: ValueKey('column'),
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _PlatformsList(),
                    SizedBox(height: 30),
                    _SkillsList(),
                  ],
                )
              : Row(
                  key: ValueKey('row'),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _PlatformsList(),
                    SizedBox(width: 50),
                    Flexible(child: _SkillsList()),
                  ],
                ),
        );
      },
    );
  }
}

class _PlatformsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 450),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          for (var i = 0; i < platformsIcon.length; i++)
            _AnimatedAppear(
              delay: Duration(milliseconds: 400 + i * 80),
              child: _AnimatedPlatformItem(
                icon: platformsIcon[i]['icon']!,
                name: platformsIcon[i]['name']!,
                delay: 400 + i * 50,
              ),
            ),
        ],
      ),
    );
  }
}

class _AnimatedPlatformItem extends StatefulWidget {
  final String icon;
  final String name;
  final int delay;

  const _AnimatedPlatformItem({
    required this.icon,
    required this.name,
    required this.delay,
    Key? key,
  }) : super(key: key);

  @override
  State<_AnimatedPlatformItem> createState() => _AnimatedPlatformItemState();
}

class _AnimatedPlatformItemState extends State<_AnimatedPlatformItem> {
  double _scale = 1.0;

  void _onEnter(PointerEvent _) => setState(() => _scale = 1.05);
  void _onExit(PointerEvent _) => setState(() => _scale = 1.0);
  void _onTapDown(TapDownDetails _) => setState(() => _scale = 0.95);
  void _onTapUp(TapUpDetails _) => setState(() => _scale = 1.05);
  void _onTapCancel() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedScale(
          scale: _scale,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: AnimatedContainer(
            duration: Duration(milliseconds: widget.delay),
            curve: Curves.easeInOut,
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
                widget.icon,
                width: 40,
                height: 40,
                color: CustomColor.whiteSecondary,
                fit: BoxFit.cover,
              ),
              title: Text(
                widget.name,
                style: TextStyle(
                  color: CustomColor.whitePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SkillsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          for (var i = 0; i < skillsIcon.length; i++)
            _AnimatedAppear(
              delay: Duration(milliseconds: 400 + i * 80),
              child: _AnimatedSkillChip(
                icon: skillsIcon[i]['icon']!,
                name: skillsIcon[i]['name']!,
                delay: 400 + i * 50,
              ),
            ),
        ],
      ),
    );
  }
}

class _AnimatedSkillChip extends StatefulWidget {
  final String icon;
  final String name;
  final int delay;

  const _AnimatedSkillChip({
    required this.icon,
    required this.name,
    required this.delay,
    Key? key,
  }) : super(key: key);

  @override
  State<_AnimatedSkillChip> createState() => _AnimatedSkillChipState();
}

class _AnimatedSkillChipState extends State<_AnimatedSkillChip> {
  double _scale = 1.0;

  void _onEnter(PointerEvent _) => setState(() => _scale = 1.08);
  void _onExit(PointerEvent _) => setState(() => _scale = 1.0);
  void _onTapDown(TapDownDetails _) => setState(() => _scale = 0.95);
  void _onTapUp(TapUpDetails _) => setState(() => _scale = 1.08);
  void _onTapCancel() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedScale(
          scale: _scale,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: Chip(
            backgroundColor: CustomColor.bgLight2,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            avatar: Image.asset(
              widget.icon,
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
            label: Text(
              widget.name,
              style: TextStyle(
                color: CustomColor.whitePrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedAppear extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const _AnimatedAppear({required this.child, required this.delay, Key? key})
    : super(key: key);

  @override
  State<_AnimatedAppear> createState() => _AnimatedAppearState();
}

class _AnimatedAppearState extends State<_AnimatedAppear>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _offset = Tween<Offset>(
      begin: Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _offset, child: widget.child),
    );
  }
}
