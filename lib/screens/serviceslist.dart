import 'dart:convert';

import 'package:car_app/models/schedule.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Serviceslist extends StatefulWidget {
  @override
  _ServiceslistState createState() => _ServiceslistState();
}

class _ServiceslistState extends State<Serviceslist> {
  final key = GlobalKey<ScaffoldState>();

  List<Schedule> list = [];
  @override
  void initState() {
    // TODO: implement initState
    Schedule schedule = Schedule();
    schedule.client = "Bruno";
    schedule.date = "2020-10-29";
    schedule.hours = "10:02";
    schedule.sevice = "Lavagem Simples";
    setState(() {
      // list.add(schedule);
      _reloadList();
    });
    super.initState();
  }

  _reloadList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('listSchedule');

    if (data != null) {
      setState(() {
        var objs = jsonDecode(data) as List;
        list = objs.map((obj) => Schedule.fromJson(obj)).toList();
      });
    }
  }

  _removeItem(int index) {
    setState(() {
      list.removeAt(index);
    });

    SharedPreferences.getInstance()
        .then((prefs) => prefs.setString('listSchedule', jsonEncode(list)));
  }

  _showAlertDialogue(
      BuildContext context, Function confirmfunction, int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Cofirmação'),
            content: Text('Tem certeza que quer excluir esse item?'),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.pop(context), child: Text('Não')),
              FlatButton(
                  child: Text('Sim'),
                  onPressed: () {
                    confirmfunction(index);
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Agenda'),
          centerTitle: true,
        ),
        body: ListView.separated(
          itemCount: list.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${list[index].client}', style: TextStyle(height: 2)),
              subtitle: Text(
                'Serviço: ${list[index].sevice} | Data: ${list[index].date} | Horas: ${list[index].hours}',
                style: TextStyle(height: 1.2),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _showAlertDialogue(context, _removeItem, index);
                    },
                    color: Colors.red,
                  )
                ],
              ),
            );
          },
        ));
  }
}
