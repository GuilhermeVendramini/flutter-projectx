import 'package:flutter/material.dart';
import 'package:projetcx/app/models/page.dart';

import 'manage_form.dart';

class PluginTextField extends StatelessWidget {
  final PageModel item;

  PluginTextField({this.item});

  @override
  Widget build(BuildContext context) {
    return PluginTextFieldManageForm(item: item);
  }
}
