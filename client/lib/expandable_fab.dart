import 'package:flutter/material.dart';
import 'dart:math';
import 'seizure_log_form.dart';

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    this.baseAngle, // angle in degrees first item should be placed at. zero is horizontal left
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final double? baseAngle;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  bool _open = false;
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: FloatingActionButton(
        heroTag: "closeFAB",
        backgroundColor: Colors.white,
        elevation: 4.0,
        onPressed: _toggle,
        child: const Icon(
          Icons.close,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            heroTag: "openFAB",
            backgroundColor: const Color.fromARGB(255, 217, 217, 217),
            elevation: 0.0,
            onPressed: _toggle,
            child: const Icon(Icons.add, size: 40, color: Colors.black),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final baseAngle = widget.baseAngle ?? 0;
    final step = (90 - baseAngle * 2) / (count - 1);
    for (var i = 0, angleInDegrees = baseAngle;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton(
      {super.key, this.onPressed, required this.icon, this.buttonText});

  final VoidCallback? onPressed;
  final IconData icon;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: (onPressed),
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(children: [
                  Text(buttonText ?? "",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(width: 5),
                  Icon(
                    icon,
                    size: 30.0,
                    color: Colors.black,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ]))));
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
            right: 4.0 + offset.dx,
            bottom: 4.0 + offset.dy,
            child:
                child! /*Transform.rotate(
            angle: (1.0 - progress.value) * pi / 2,
            child: child!,
          ),*/
            );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

Widget entriesFAB(context) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: ExpandableFab(
      distance: 60.0,
      baseAngle: 10,
      children: [
        ActionButton(
          onPressed: () => {},
          icon: Icons.add_to_photos,
          buttonText: "Track symptoms",
        ),
        ActionButton(
          onPressed: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const SeizureLogPage();
            }))
          },
          icon: Icons.add,
          buttonText: "Add a new seizure log",
        ),
      ],
    ),
  );
}
