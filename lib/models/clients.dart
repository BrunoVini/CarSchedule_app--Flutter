class Client {
  String name;
  String phoneNumber;

  Client({this.name, this.phoneNumber});

  Client.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
  }

  Map toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
