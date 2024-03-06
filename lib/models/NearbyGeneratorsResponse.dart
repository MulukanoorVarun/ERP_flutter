import 'package:GenERP/screens/GenTechnicianModule/NearbyGenerators.dart';

class NearbyGeneratorsResponse {
  List<Nearbygenerators>? list;
  int? error;
  int? sessionExists;

  NearbyGeneratorsResponse({this.list, this.error, this.sessionExists});

  NearbyGeneratorsResponse.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <Nearbygenerators>[];
      json['list'].forEach((v) {
        list!.add(new Nearbygenerators.fromJson(v));
      });
    }
    error = json['error'];
    sessionExists = json['session_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['session_exists'] = this.sessionExists;
    return data;
  }
}

class Nearbygenerators {
  String? generatorId;
  String? loc;
  String? productName;
  String? accName;
  String? distance;

  Nearbygenerators(
      {this.generatorId,
        this.loc,
        this.productName,
        this.accName,
        this.distance});

  Nearbygenerators.fromJson(Map<String, dynamic> json) {
    generatorId = json['generator_id'];
    loc = json['loc'];
    productName = json['product_name'];
    accName = json['acc_name'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['generator_id'] = this.generatorId;
    data['loc'] = this.loc;
    data['product_name'] = this.productName;
    data['acc_name'] = this.accName;
    data['distance'] = this.distance;
    return data;
  }
}