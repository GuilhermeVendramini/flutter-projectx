import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/strings.dart';
import 'package:projetcx/app/ui/page/manage_form.dart';

class PageClean extends StatefulWidget {
  @override
  _PageCleanState createState() => _PageCleanState();
}

class _PageCleanState extends State<PageClean> {
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.0),
      child: SafeArea(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageManageForm(),
                ),
              );
            },
            child: Card(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    size: 52.0,
                    color: color,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    Strings.addPage.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
