import 'package:car_app/screens/listclients.dart';
import 'package:car_app/screens/scheduleService.dart';
import 'package:car_app/screens/serviceslist.dart';
import 'package:car_app/screens/singinclients.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ButtonTheme(
                height: 50,
                minWidth: 200,
                child: RaisedButton(
                  child: Text(
                    'Cadastro de Clientes',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SinginClient()));
                  },
                  elevation: 5.0,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ButtonTheme(
                height: 50,
                minWidth: 218,
                child: RaisedButton(
                  child: Text(
                    'Agendar Serviço',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScheduleService()));
                  },
                  elevation: 5.0,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ButtonTheme(
                height: 50,
                minWidth: 218,
                child: RaisedButton(
                  child: Text(
                    'Agenda',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Serviceslist()));
                  },
                  elevation: 5.0,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ButtonTheme(
                height: 50,
                minWidth: 218,
                child: RaisedButton(
                  child: Text(
                    'Lista de Clientes',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListClients()));
                  },
                  elevation: 5.0,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
