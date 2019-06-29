import 'package:flutter/material.dart';
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/plugins/types/textfield/controllers/textfield.dart';
import 'package:provider/provider.dart';

import 'manage_form.dart';

class PluginTextField extends StatelessWidget {
  final PageModel item;

  PluginTextField({this.item});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PluginTextFieldService>(
            builder: (_) => PluginTextFieldService()),
      ],
      child: PluginTextFieldManageForm(item: item),
    );
  }
}
