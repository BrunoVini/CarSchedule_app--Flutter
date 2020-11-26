import 'dart:convert';

import 'package:car_app/models/clients.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListClients extends StatefulWidget {
  @override
  _ListClientsState createState() => _ListClientsState();
}

class _ListClientsState extends State<ListClients> {
  List<Client> list = [];

  @override
  void initState() {
    super.initState();
    // Client client = Client();
    // client.name = 'Bruno Souza';
    // client.phoneNumber = '+55 71 99999-9999';
    setState(() {
      _reloadList();
    });
  }

  _reloadList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('listClients');

    if (data != null) {
      setState(() {
        var objs = jsonDecode(data) as List;
        list = objs.map((obj) => Client.fromJson(obj)).toList();
      });
    }
  }

  _removeItem(int index) {
    setState(() {
      list.removeAt(index);
    });

    SharedPreferences.getInstance()
        .then((prefs) => prefs.setString('listClients', jsonEncode(list)));
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
          title: Text('Lista de Clientes'),
          centerTitle: true,
        ),
        body: ListView.separated(
          itemCount: list.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${list[index].name}'),
              subtitle: Text('${list[index].phoneNumber}'),
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
