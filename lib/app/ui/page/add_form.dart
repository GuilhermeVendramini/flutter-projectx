import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/app_colors.dart';
import 'package:projetcx/app/constants/strings.dart';
import 'package:projetcx/app/controllers/page.dart';
import 'package:projetcx/app/ui/home/home.dart';
import 'package:projetcx/app/widgets/fields/color_picker.dart';
import 'package:projetcx/app/widgets/fields/text_field.dart';
import 'package:projetcx/app/widgets/utils/gradient_background.dart';
import 'package:provider/provider.dart';

class PageAddForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PageAddForm();
  }
}

class _PageAddForm extends State<PageAddForm> {
  final Map<String, dynamic> _formData = {
    'name': null,
    'color': null,
    'weight': 0,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Color _pageColor;

  @override
  void initState() {
    super.initState();
    setState(() {
      _pageColor = AppColors.defaultColors[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final _page = Provider.of<PageService>(context);
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: _pageForm(context),
                  ),
                ),
              ),
            ),
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _submitForm(_page, context),
          child: Icon(
            Icons.done,
            size: 40.0,
          ),
        ),
      ),
    );
  }

  Widget _pageForm(BuildContext context) {
    return GradientBackground(
      color: _pageColor,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0,
              ),
              FieldColorPicker(
                  color: _pageColor,
                  onColorChanged: (color) {
                    setState(() {
                      _pageColor = color;
                      _formData['color'] = color.value;
                    });
                  }),
              SizedBox(
                height: 20.0,
              ),
              FieldTextField(
                hintText: Strings.fieldPageName,
                autoFocus: true,
                onSaved: (name) {
                  setState(() {
                    _formData['name'] = name;
                  });
                },
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm(
      PageService page, BuildContext context) async {
    _formKey.currentState.save();
    await page.addItem(_formData);
    Route route = MaterialPageRoute(
      builder: (context) => HomeScreen(),
    );
    Navigator.push(context, route);
  }
}
