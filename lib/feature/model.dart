class Patient {
  String? name;
  int? age;
  String? phone;
  String? address;
  String? screenshotPath;
  Patient({
    this.name,
    this.age,
    this.phone,
    this.address,
    this.screenshotPath,
  });
  Patient.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    phone = json['phone'];
    address = json['address'];
    screenshotPath = json['screenshotPath'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['screenshotPath'] = this.screenshotPath;
    return data;
  }
}

