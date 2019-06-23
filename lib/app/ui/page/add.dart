import 'package:flutter/material.dart';
import 'package:projetcx/app/ui/page/form.dart';

class PageAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PageAdd();
  }
}

class _PageAdd extends State<PageAdd> {
  @override
  Widget build(BuildContext context) {
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
                    child: PageForm(),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
