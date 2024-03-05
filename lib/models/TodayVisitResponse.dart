class TodayVisitResponse {
  List<Visitlist>? list;
  int? error;
  int? sessionExists;

  TodayVisitResponse({this.list, this.error, this.sessionExists});

  TodayVisitResponse.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <Visitlist>[];
      json['list'].forEach((v) {
        list!.add(new Visitlist.fromJson(v));
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

class Visitlist {
  String? genId;
  String? complaintId;
  String? address;
  String? loc;
  String? mobileNo;
  String? followupId;
  String? companyName;
  String? productName;
  String? complaintCategory;
  String? visitDatetime;

  Visitlist(
      {this.genId,
        this.complaintId,
        this.address,
        this.loc,
        this.mobileNo,
        this.followupId,
        this.companyName,
        this.productName,
        this.complaintCategory,
        this.visitDatetime});

  Visitlist.fromJson(Map<String, dynamic> json) {
    genId = json['gen_id'];
    complaintId = json['complaint_id'];
    address = json['address'];
    loc = json['loc'];
    mobileNo = json['mobile_no'];
    followupId = json['followup_id'];
    companyName = json['company_name'];
    productName = json['product_name'];
    complaintCategory = json['complaint_category'];
    visitDatetime = json['visit_datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gen_id'] = this.genId;
    data['complaint_id'] = this.complaintId;
    data['address'] = this.address;
    data['loc'] = this.loc;
    data['mobile_no'] = this.mobileNo;
    data['followup_id'] = this.followupId;
    data['company_name'] = this.companyName;
    data['product_name'] = this.productName;
    data['complaint_category'] = this.complaintCategory;
    data['visit_datetime'] = this.visitDatetime;
    return data;
  }
}