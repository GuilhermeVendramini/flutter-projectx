import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/strings.dart';
import 'package:projetcx/app/controllers/page.dart' as p;
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/ui/page/reorder.dart';
import 'package:provider/provider.dart';

const Color color = Colors.white;

class OptionsButton extends StatelessWidget {
  final AnimationController _controller;

  OptionsButton(this._controller);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () {
            if (_controller.isDismissed) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
          },
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget child) {
              return Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                child: Icon(
                  _controller.isDismissed ? Icons.more_vert : Icons.close,
                  color: color.withOpacity(0.8),
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
  final Animation<double> _controller;

  OptionEditButton(this._controller);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40.0,
      right: 0.0,
      child: GestureDetector(
        child: Container(
          child: ScaleTransition(
            scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 1.0, curve: Curves.easeOut)),
            child: Icon(
              Icons.edit,
              color: color.withOpacity(0.8),
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

class OptionDeleteButton extends StatelessWidget {
  final Animation<double> _controller;
  final PageModel _item;

  OptionDeleteButton(this._controller, this._item);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 120.0,
      right: 0.0,
      child: GestureDetector(
        child: Container(
          child: ScaleTransition(
            scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 1.0, curve: Curves.easeOut)),
            child: Icon(
              Icons.delete,
              color: color.withOpacity(0.8),
            ),
          ),
        ),
        onTap: () {
          _showDialog(context);
        },
      ),
    );
  }

  void _showDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.2),
          title: Center(
            child: Text(Strings.confirmDeleteBox),
          ),
          content: Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              _yesAction(context),
            ],
          ),
        );
      },
    );
  }

  Widget _yesAction(BuildContext context) {
    final p.PageService _page = Provider.of<p.PageService>(context);
    return Container(
      height: 50.0,
      width: 100.0,
      child: RaisedButton(
        color: color,
        child: Text(
          Strings.yes,
        ),
        onPressed: () async {
          await _page.deleteItem(_item);
          _page.notifyChange();
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
