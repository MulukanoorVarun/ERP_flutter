class ComplaintsSelectionResponse {
  List<ServiceComptType>? serviceComptType;
  List<ServiceComptCat>? serviceComptCat;
  List<ServiceComptDesc>? serviceComptDesc;
  int? error;
  int? sessionExists;

  ComplaintsSelectionResponse(
      {this.serviceComptType,
        this.serviceComptCat,
        this.serviceComptDesc,
        this.error,
        this.sessionExists});

  ComplaintsSelectionResponse.fromJson(Map<String, dynamic> json) {
    if (json['service_compt_type'] != null) {
      serviceComptType = <ServiceComptType>[];
      json['service_compt_type'].forEach((v) {
        serviceComptType!.add(new ServiceComptType.fromJson(v));
      });
    }
    if (json['service_compt_cat'] != null) {
      serviceComptCat = <ServiceComptCat>[];
      json['service_compt_cat'].forEach((v) {
        serviceComptCat!.add(new ServiceComptCat.fromJson(v));
      });
    }
    if (json['service_compt_desc'] != null) {
      serviceComptDesc = <ServiceComptDesc>[];
      json['service_compt_desc'].forEach((v) {
        serviceComptDesc!.add(new ServiceComptDesc.fromJson(v));
      });
    }
    error = json['error'];
    sessionExists = json['session_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.serviceComptType != null) {
      data['service_compt_type'] =
          this.serviceComptType!.map((v) => v.toJson()).toList();
    }
    if (this.serviceComptCat != null) {
      data['service_compt_cat'] =
          this.serviceComptCat!.map((v) => v.toJson()).toList();
    }
    if (this.serviceComptDesc != null) {
      data['service_compt_desc'] =
          this.serviceComptDesc!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['session_exists'] = this.sessionExists;
    return data;
  }
}

class ServiceComptType {
  String? id;
  String? name;

  ServiceComptType({this.id, this.name});

  ServiceComptType.fromJson(Map<String, dynamic> json) {
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
class ServiceComptCat {
  String? id;
  String? name;

  ServiceComptCat({this.id, this.name});

  ServiceComptCat.fromJson(Map<String, dynamic> json) {
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
class ServiceComptDesc {
  String? id;
  String? name;

  ServiceComptDesc({this.id, this.name});

  ServiceComptDesc.fromJson(Map<String, dynamic> json) {
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