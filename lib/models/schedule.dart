class Schedule {
  String client;
  String date;
  String hours;
  String sevice;

  Schedule({this.client, this.date, this.hours, this.sevice});

  Schedule.fromJson(Map<String, dynamic> json) {
    client = json['client'];
    date = json['date'];
    hours = json['hours'];
    sevice = json['sevice'];
  }

  Map toJson() => {
        'client': client,
        'date': date,
        'hours': hours,
        'sevice': sevice,
      };

  // Map toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['client'] = this.client;
  //   data['date'] = this.date;
  //   data['hours'] = this.hours;
  //   data['sevice'] = this.sevice;
  //   return data;
  // }
}
