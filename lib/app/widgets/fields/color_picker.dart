import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:projetcx/app/constants/app_colors.dart';
import 'package:projetcx/app/constants/strings.dart';

class FieldColorPicker extends StatelessWidget {
  final Color color;
  final ValueChanged<Color> onColorChanged;

  FieldColorPicker({@required this.color, @required this.onColorChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titlePadding: EdgeInsets.only(top: 40.0),
              backgroundColor: Colors.transparent,
              title: Text(
                Strings.colorTitleBox,
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: BlockPicker(
                  availableColors: AppColors.defaultColors,
                  pickerColor: color,
                  onColorChanged: onColorChanged,
                ),
              ),
            );
          },
        );
      },
      child: Container(
        height: 48.0,
        width: 48.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
          color: color,
        ),
      ),
    );
  }
}
