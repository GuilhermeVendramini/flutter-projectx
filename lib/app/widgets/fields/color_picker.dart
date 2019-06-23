import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:projetcx/app/constants/app_colors.dart';

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
              backgroundColor: Colors.transparent,
              title: Text(
                'CHOOSE A COLOR',
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
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            color: Colors.white.withOpacity(0.8),
            width: 4.0,
          ),
          color: color,
        ),
      ),
    );
  }
}
