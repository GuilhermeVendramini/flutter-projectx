import 'package:flutter/material.dart';
import 'package:projetcx/app/plugins/controllers/plugins.dart';
import 'package:projetcx/app/plugins/data/plugins.dart';
import 'package:provider/provider.dart';

class PluginsScreen extends StatefulWidget {
  final dynamic item;

  PluginsScreen(this.item);

  @override
  _PluginsScreenState createState() => _PluginsScreenState();
}

class _PluginsScreenState extends State<PluginsScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            padding: EdgeInsets.all(10.0),
            children: List.generate(pluginsData.length, (index) {
              return Center(
                child: pluginsCard(index),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget pluginsCard(int index) {
    final PluginService _plugin = Provider.of<PluginService>(context);
    final Color color = Colors.blueGrey;
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _plugin.action(
                    pluginType: pluginsData[index].pluginType,
                    item: widget.item,
                  ),
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
                pluginsData[index].icon,
                color: color,
                size: 48.0,
              ),
              Text(
                pluginsData[index].name,
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
