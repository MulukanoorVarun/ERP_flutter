class TechnicianPendingComplaintsResponse {
  List<TP_List>? list;
  int? error;
  int? sessionExists;

  TechnicianPendingComplaintsResponse(
      {this.list, this.error, this.sessionExists});

  TechnicianPendingComplaintsResponse.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <TP_List>[];
      json['list'].forEach((v) {
        list!.add(new TP_List.fromJson(v));
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

class TP_List {
  String? genId;
  String? address;
  String? loc;
  String? complaintId;
  String? companyName;
  String? productName;
  String? complaintCategory;
  String? compRegDatetime;
  String? mobileNo;

  TP_List(
      {this.genId,
        this.address,
        this.loc,
        this.complaintId,
        this.companyName,
        this.productName,
        this.complaintCategory,
        this.compRegDatetime,
        this.mobileNo});

  TP_List.fromJson(Map<String, dynamic> json) {
    genId = json['gen_id'];
    address = json['address'];
    loc = json['loc'];
    complaintId = json['complaint_id'];
    companyName = json['company_name'];
    productName = json['product_name'];
    complaintCategory = json['complaint_category'];
    compRegDatetime = json['comp_reg_datetime'];
    mobileNo = json['mobile_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gen_id'] = this.genId;
    data['address'] = this.address;
    data['loc'] = this.loc;
    data['complaint_id'] = this.complaintId;
    data['company_name'] = this.companyName;
    data['product_name'] = this.productName;
    data['complaint_category'] = this.complaintCategory;
    data['comp_reg_datetime'] = this.compRegDatetime;
    data['mobile_no'] = this.mobileNo;
    return data;
  }
}
