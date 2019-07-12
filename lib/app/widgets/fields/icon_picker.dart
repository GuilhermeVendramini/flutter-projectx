import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/strings.dart';
import 'package:projetcx/app/widgets/icon_picker/icon_display.dart';
import 'package:projetcx/app/widgets/icon_picker/icon_picker.dart';

class FieldIconPicker extends StatelessWidget {
  final IconData iconData;
  final ValueChanged<IconData> action;

  FieldIconPicker({
    @required this.iconData,
    @required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.0),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titlePadding: EdgeInsets.only(top: 40.0),
              backgroundColor: Colors.transparent,
              title: Text(
                Strings.iconTitleBox,
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: IconPicker(
                  currentIconData: iconData,
                  onIconChanged: action,
                ),
              ),
            );
          },
        );
      },
      child: IconDisplay(
        codePoint: iconData.codePoint,
      ),
    );
  }
}
