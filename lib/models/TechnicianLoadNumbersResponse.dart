class TechnicianLoadNumbersResponse {
  List<PaymentModeList>? paymentModeList;
  List<Contacts>? contacts;
  int? error;
  int? sessionExists;

  TechnicianLoadNumbersResponse(
      {this.paymentModeList, this.contacts, this.error, this.sessionExists});

  TechnicianLoadNumbersResponse.fromJson(Map<String, dynamic> json) {
    if (json['payment_mode_list'] != null) {
      paymentModeList = <PaymentModeList>[];
      json['payment_mode_list'].forEach((v) {
        paymentModeList!.add(new PaymentModeList.fromJson(v));
      });
    }
    if (json['contacts'] != null) {
      contacts = <Contacts>[];
      json['contacts'].forEach((v) {
        contacts!.add(new Contacts.fromJson(v));
      });
    }
    error = json['error'];
    sessionExists = json['session_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentModeList != null) {
      data['payment_mode_list'] =
          this.paymentModeList!.map((v) => v.toJson()).toList();
    }
    if (this.contacts != null) {
      data['contacts'] = this.contacts!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['session_exists'] = this.sessionExists;
    return data;
  }
}

class PaymentModeList {
  String? id;
  String? name;

  PaymentModeList({this.id, this.name});

  PaymentModeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Contacts {
  String? mob1;
  String? name;

  Contacts({this.mob1, this.name});

  Contacts.fromJson(Map<String, dynamic> json) {
    mob1 = json['mob1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mob1'] = this.mob1;
    data['name'] = this.name;
    return data;
  }
}
