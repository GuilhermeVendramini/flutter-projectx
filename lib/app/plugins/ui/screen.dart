import 'package:flutter/material.dart';
import 'package:projetcx/app/models/page.dart';
import 'package:projetcx/app/plugins/controllers/plugins.dart';
import 'package:projetcx/app/plugins/register.dart';
import 'package:projetcx/app/ui/page/manage_form.dart';
import 'package:provider/provider.dart';

class PluginsScreen extends StatefulWidget {
  final PageModel item;

  PluginsScreen(this.item);

  @override
  _PluginsScreenState createState() => _PluginsScreenState();
}

class _PluginsScreenState extends State<PluginsScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PageManageForm(item: widget.item),
          ),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            padding: EdgeInsets.all(10.0),
            children: List.generate(pluginsRegister.length, (index) {
              return Center(
                child: _pluginsCard(index),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _pluginsCard(int index) {
    final PluginService _plugin = Provider.of<PluginService>(context);
    final Color color = Colors.blueGrey;
    return Card(
      child: InkWell(
        onTap: () {
          _plugin.setCurrentParent(widget.item);
          _plugin.setCurrentItem(null);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => pluginsRegister[index].form,
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                pluginsRegister[index].icon,
                color: color,
                size: 48.0,
              ),
              Text(
                pluginsRegister[index].name,
                style: TextStyle(
                  color: color,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
