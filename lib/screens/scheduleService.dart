import 'dart:convert';

import 'package:car_app/models/schedule.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleService extends StatefulWidget {
  @override
  _ScheduleServiceState createState() => _ScheduleServiceState();
}

class _ScheduleServiceState extends State<ScheduleService> {
  Schedule _schedule;

  final key = GlobalKey<ScaffoldState>();

  final format = DateFormat("dd-MM-yyyy");
  final TextEditingController _nameClient = TextEditingController();
  final TextEditingController _dateYear = TextEditingController();
  final TextEditingController _timeHours = TextEditingController();

  String dateTime;
  String hours;

  String serviceCar;

  var checkedValue1 = false;
  var checkedValue2 = false;
  var checkedValue3 = false;

  setInputs(String a, String b) {
    if (a == "truea") {
      setState(() {
        checkedValue2 = false;
        checkedValue3 = false;
      });
    }
    if (a == "trueb") {
      setState(() {
        checkedValue1 = false;
        checkedValue3 = false;
      });
    }
    if (a == "truec") {
      setState(() {
        checkedValue1 = false;
        checkedValue2 = false;
      });
    }

    setState(() {
      if (checkedValue1 == false &&
          checkedValue2 == false &&
          checkedValue3 == false) {
        setState(() {
          serviceCar = '';
        });
      } else {
        serviceCar = b;
      }
    });
  }

  _safeItem() async {
    if (_nameClient.text.isEmpty ||
        dateTime == '' ||
        hours == '' ||
        serviceCar == '') {
      key.currentState.showSnackBar(SnackBar(
        content: Text('Todos os campos são obrigatórios.'),
      ));
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<Schedule> list = [];

      var data = prefs.getString('listSchedule');
      _schedule = Schedule(
          client: _nameClient.text,
          date: dateTime,
          hours: hours,
          sevice: serviceCar);

      if (data != null) {
        var objs = jsonDecode(data) as List;
        list = objs.map((obj) => Schedule.fromJson(obj)).toList();
      }

      list.add(_schedule);

      prefs.setString('listSchedule', jsonEncode(list));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text('Agendar Serviço'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Cliente:', style: TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.name,
                controller: _nameClient,
                decoration: (InputDecoration(
                    hintText: 'Nome',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Data:', style: TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.datetime,
                controller: _dateYear,
                readOnly: true,
                decoration: (InputDecoration(
                    hintText: 'Selecione a Data',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)))),
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate:
                              dateTime == null ? DateTime.now() : dateTime,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2022))
                      .then((date) {
                    setState(() {
                      dateTime = date.toString();
                      if (date != null) {
                        var dateTimes = dateTime.split('-');
                        var dia = dateTimes[2].split(' ')[0];
                        var mes = dateTimes[1];
                        var ano = dateTimes[0];
                        _dateYear.text = '${dia}-${mes}-${ano}';
                      } else {
                        _dateYear.text = '';
                      }
                    });
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Hora:', style: TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.datetime,
                controller: _timeHours,
                readOnly: true,
                decoration: (InputDecoration(
                    hintText: 'Selecione a Hora',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)))),
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((hour) {
                    if (hour != null) {
                      setState(() {
                        hours = hour.toString();
                        hours = hours.split('(')[1];
                        hours = hours.split(')')[0];
                        _timeHours.text = "$hours";
                      });
                    } else {
                      _timeHours.text = "";
                    }
                  });
                },
              ),
            ),
            CheckboxListTile(
              title: Text('Lavagem Simples'),
              value: checkedValue1,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool valor) {
                setState(() {
                  checkedValue1 = valor;
                  setInputs('${checkedValue1}a', 'Lavagem Simples');
                });
              },
            ),
            CheckboxListTile(
              title: Text('Lavagem completa sem cera'),
              value: checkedValue2,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool valor) {
                setState(() {
                  checkedValue2 = valor;
                  setInputs('${checkedValue2}b', 'Lavagem completa sem cera');
                });
              },
            ),
            CheckboxListTile(
              title: Text('Lavagem completa com cera'),
              value: checkedValue3,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool valor) {
                setState(() {
                  checkedValue3 = valor;
                  setInputs('${checkedValue3}c', 'Lavagem completa com cera');
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonTheme(
                height: 45,
                minWidth: double.infinity,
                child: RaisedButton(
                  child: Text('Salvar', style: TextStyle(color: Colors.white)),
                  onPressed: _safeItem,
                  elevation: 6.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
