import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/strings.dart';
import 'package:projetcx/app/ui/category/manage_form.dart';

class CategoryClean extends StatefulWidget {
  @override
  _CategoryCleanState createState() => _CategoryCleanState();
}

class _CategoryCleanState extends State<CategoryClean> {
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
                  builder: (context) => CategoryManageForm(),
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
                    Strings.addCategory.toUpperCase(),
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
