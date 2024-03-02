class loadGeneratorDetailsResponse {
  int? error;
  String? genId;
  String? aname;
  String? emodel;
  String? spname;
  String? mob1;
  String? mob2;
  String? mail;
  String? cname;
  String? engineNo;
  String? dateOfEngineSale;
  String? altNo;
  String? btryNo;
  String? dgSetNo;
  String? state;
  String? district;
  String? address;
  String? dispDate;
  String? cmsngDate;
  String? status;
  List<ComplaintCategoryList>? complaintCategoryList;
  List<ComplaintTypeList>? complaintTypeList;
  List<ComplaintDescriptionList>? complaintDescriptionList;
  String? nextService;
  int? sessionExists;

  loadGeneratorDetailsResponse(
      {this.error,
        this.genId,
        this.aname,
        this.emodel,
        this.spname,
        this.mob1,
        this.mob2,
        this.mail,
        this.cname,
        this.engineNo,
        this.dateOfEngineSale,
        this.altNo,
        this.btryNo,
        this.dgSetNo,
        this.state,
        this.district,
        this.address,
        this.dispDate,
        this.cmsngDate,
        this.status,
        this.complaintCategoryList,
        this.complaintTypeList,
        this.complaintDescriptionList,
        this.nextService,
        this.sessionExists});

  loadGeneratorDetailsResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    genId = json['gen_id'];
    aname = json['aname'];
    emodel = json['emodel'];
    spname = json['spname'];
    mob1 = json['mob1'];
    mob2 = json['mob2'];
    mail = json['mail'];
    cname = json['cname'];
    engineNo = json['engine_no'];
    dateOfEngineSale = json['date_of_engine_sale'];
    altNo = json['alt_no'];
    btryNo = json['btry_no'];
    dgSetNo = json['dg_set_no'];
    state = json['state'];
    district = json['district'];
    address = json['address'];
    dispDate = json['disp_date'];
    cmsngDate = json['cmsng_date'];
    status = json['status'];
    if (json['complaint_category_list'] != null) {
      complaintCategoryList = <ComplaintCategoryList>[];
      json['complaint_category_list'].forEach((v) {
        complaintCategoryList!.add(new ComplaintCategoryList.fromJson(v));
      });
    }
    if (json['complaint_type_list'] != null) {
      complaintTypeList = <ComplaintTypeList>[];
      json['complaint_type_list'].forEach((v) {
        complaintTypeList!.add(new ComplaintTypeList.fromJson(v));
      });
    }
    if (json['complaint_description_list'] != null) {
      complaintDescriptionList = <ComplaintDescriptionList>[];
      json['complaint_description_list'].forEach((v) {
        complaintDescriptionList!.add(new ComplaintDescriptionList.fromJson(v));
      });
    }
    nextService = json['next_service'];
    sessionExists = json['session_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['gen_id'] = this.genId;
    data['aname'] = this.aname;
    data['emodel'] = this.emodel;
    data['spname'] = this.spname;
    data['mob1'] = this.mob1;
    data['mob2'] = this.mob2;
    data['mail'] = this.mail;
    data['cname'] = this.cname;
    data['engine_no'] = this.engineNo;
    data['date_of_engine_sale'] = this.dateOfEngineSale;
    data['alt_no'] = this.altNo;
    data['btry_no'] = this.btryNo;
    data['dg_set_no'] = this.dgSetNo;
    data['state'] = this.state;
    data['district'] = this.district;
    data['address'] = this.address;
    data['disp_date'] = this.dispDate;
    data['cmsng_date'] = this.cmsngDate;
    data['status'] = this.status;
    if (this.complaintCategoryList != null) {
      data['complaint_category_list'] =
          this.complaintCategoryList!.map((v) => v.toJson()).toList();
    }
    if (this.complaintTypeList != null) {
      data['complaint_type_list'] =
          this.complaintTypeList!.map((v) => v.toJson()).toList();
    }
    if (this.complaintDescriptionList != null) {
      data['complaint_description_list'] =
          this.complaintDescriptionList!.map((v) => v.toJson()).toList();
    }
    data['next_service'] = this.nextService;
    data['session_exists'] = this.sessionExists;
    return data;
  }
}

class ComplaintCategoryList {
  String? id;
  String? name;

  ComplaintCategoryList({this.id, this.name});

  ComplaintCategoryList.fromJson(Map<String, dynamic> json) {
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
class ComplaintTypeList {
  String? id;
  String? name;

  ComplaintTypeList({this.id, this.name});

  ComplaintTypeList.fromJson(Map<String, dynamic> json) {
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
class ComplaintDescriptionList {
  String? id;
  String? name;

  ComplaintDescriptionList({this.id, this.name});

  ComplaintDescriptionList.fromJson(Map<String, dynamic> json) {
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