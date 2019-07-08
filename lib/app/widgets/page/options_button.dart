import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/strings.dart';
import 'package:projetcx/app/controllers/page.dart' as p;
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/ui/home/screen.dart';
import 'package:projetcx/app/ui/page/manage_form.dart';
import 'package:projetcx/app/ui/page/reorder.dart';
import 'package:provider/provider.dart';

const Color color = Colors.white;

class PageOptionsButton extends StatelessWidget {
  final AnimationController _controller;

  PageOptionsButton(this._controller);

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

class PageOptionEditButton extends StatelessWidget {
  final Animation<double> _controller;
  final PageModel _item;

  PageOptionEditButton(this._controller, this._item);

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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PageManageForm(item: _item),
            ),
          );
        },
      ),
    );
  }
}

class PageOptionReorderButton extends StatelessWidget {
  final Animation<double> controller;

  PageOptionReorderButton(this.controller);

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

class PageOptionDeleteButton extends StatefulWidget {
  final Animation<double> _controller;
  final PageModel _item;

  PageOptionDeleteButton(this._controller, this._item);

  @override
  _PageOptionDeleteButtonState createState() => _PageOptionDeleteButtonState();
}

class _PageOptionDeleteButtonState extends State<PageOptionDeleteButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 120.0,
      right: 0.0,
      child: GestureDetector(
        child: Container(
          child: ScaleTransition(
            scale: CurvedAnimation(
                parent: widget._controller,
                curve: Interval(0.0, 1.0, curve: Curves.easeOut)),
            child: Icon(
              Icons.delete,
              color: color.withOpacity(0.8),
            ),
          ),
        ),
        onTap: () {
          _pageShowDialog(context, _actionDelete);
        },
      ),
    );
  }

  void _actionDelete() async {
    final p.PageService _page = Provider.of<p.PageService>(context);
    await _page.deleteItem(widget._item);
    _page.notifyChange();
    Navigator.of(context).pop();
  }
}

class PageDeleteButton extends StatefulWidget {
  final PageModel item;

  PageDeleteButton(this.item);

  @override
  _PageDeleteButtonState createState() => _PageDeleteButtonState();
}

class _PageDeleteButtonState extends State<PageDeleteButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'delete',
      onPressed: () {
        _pageShowDialog(context, _actionDelete);
      },
      child: Icon(
        Icons.delete_outline,
      ),
    );
  }

  void _actionDelete() async {
    final p.PageService _page = Provider.of<p.PageService>(context);
    await _page.deleteItem(widget.item);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }
}

class PageActionDelete extends StatelessWidget {
  final Function _action;

  PageActionDelete(this._action);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 100.0,
      child: RaisedButton(
        color: color,
        child: Text(
          Strings.yes,
        ),
        onPressed: _action,
      ),
    );
  }
}

void _pageShowDialog(BuildContext context, Function actionDelete) {
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
            PageActionDelete(actionDelete),
          ],
        ),
      );
    },
  );
}
