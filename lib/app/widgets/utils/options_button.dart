import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:projetcx/app/ui/page/reorder.dart';

class OptionsButton extends StatelessWidget {
  final AnimationController controller;

  OptionsButton(this.controller);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () {
            if (controller.isDismissed) {
              controller.forward();
            } else {
              controller.reverse();
            }
          },
          child: AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget child) {
              return Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.rotationZ(controller.value * 0.5 * math.pi),
                child: Icon(
                  controller.isDismissed ? Icons.more_vert : Icons.close,
                  color: Colors.white.withOpacity(0.8),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class OptionEditButton extends StatelessWidget {
  final Animation<double> controller;

  OptionEditButton(this.controller);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40.0,
      right: 0.0,
      child: GestureDetector(
        child: Container(
          child: ScaleTransition(
            scale: CurvedAnimation(
                parent: controller,
                curve: Interval(0.0, 1.0, curve: Curves.easeOut)),
            child: Icon(
              Icons.edit,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}

class OptionReorderButton extends StatelessWidget {
  final Animation<double> controller;

  OptionReorderButton(this.controller);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80.0,
      right: 0.0,
      child: GestureDetector(
        child: Container(
          child: ScaleTransition(
            scale: CurvedAnimation(
                parent: controller,
                curve: Interval(0.0, 1.0, curve: Curves.easeOut)),
            child: Icon(
              Icons.reorder,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PageReorder(),
            ),
          );
        },
      ),
    );
  }
}
