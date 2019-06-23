import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/app_colors.dart';
import 'package:projetcx/app/widgets/fields/color_picker.dart';
import 'package:projetcx/app/widgets/fields/text_field.dart';
import 'package:projetcx/app/widgets/utils/gradient_background.dart';

class PageForm extends StatefulWidget {
  PageForm();

  @override
  State<StatefulWidget> createState() {
    return _PageFormState();
  }
}

class _PageFormState extends State<PageForm> {
  Color pageColor;

  @override
  void initState() {
    super.initState();
    setState(() {
      pageColor = AppColors.defaultColors[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      color: pageColor,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0,
              ),
              FieldColorPicker(
                color: pageColor,
                onColorChanged: (newColor) =>
                    setState(() => pageColor = newColor),
              ),
              SizedBox(
                height: 20.0,
              ),
              FieldTextField(
                hintText: 'Page name...',
                autoFocus: true,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
