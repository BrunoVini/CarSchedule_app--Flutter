import 'dart:convert';

import 'package:car_app/models/clients.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SinginClient extends StatefulWidget {
  @override
  _SinginClientState createState() => _SinginClientState();
}

class _SinginClientState extends State<SinginClient> {
  Client _client;

  final TextEditingController _nameClient = TextEditingController();
  final TextEditingController _phoneClient = TextEditingController();

  final key = GlobalKey<ScaffoldState>();

  _safeItems() async {
    if (_nameClient.text.isEmpty || _phoneClient.text.isEmpty) {
      key.currentState.showSnackBar(SnackBar(
        content: Text('Nome e Número são obrigatórios.'),
      ));
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<Client> list = [];

      var data = prefs.getString('listClients');
      _client = Client(name: _nameClient.text, phoneNumber: _phoneClient.text);
      if (data != null) {
        var objs = jsonDecode(data) as List;
        list = objs.map((obj) => Client.fromJson(obj)).toList();
      }

      list.add(_client);

      prefs.setString('listClients', jsonEncode(list));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text('Cadastrar Cliente'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Nome:', style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameClient,
              keyboardType: TextInputType.name,
              decoration: (InputDecoration(
                  hintText: 'Nome',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Número de Telefone:', style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _phoneClient,
              keyboardType:
                  TextInputType.numberWithOptions(decimal: false, signed: true),
              decoration: (InputDecoration(
                  hintText: '+55 XX XXXXX-XXXX',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonTheme(
              height: 45,
              minWidth: double.infinity,
              child: RaisedButton(
                child: Text('Salvar', style: TextStyle(color: Colors.white)),
                onPressed: _safeItems,
                elevation: 6.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
