class generatorComplaintResponse {
  int? error;
  List<C_List>? list;
  int? sessionExists;

  generatorComplaintResponse({this.error, this.list, this.sessionExists});

  generatorComplaintResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['list'] != null) {
      list = <C_List>[];
      json['list'].forEach((v) {
        list!.add(new C_List.fromJson(v));
      });
    }
    sessionExists = json['session_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    data['session_exists'] = this.sessionExists;
    return data;
  }
}

class C_List {
  String? compId;
  String? compType;
  String? compStatus;
  String? compRegdate;
  String? complaintNote;
  String? techName;

  C_List(
      {this.compId,
        this.compType,
        this.compStatus,
        this.compRegdate,
        this.complaintNote,
        this.techName});

  C_List.fromJson(Map<String, dynamic> json) {
    compId = json['comp_id'];
    compType = json['comp_type'];
    compStatus = json['comp_status'];
    compRegdate = json['comp_regdate'];
    complaintNote = json['complaint_note'];
    techName = json['tech_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comp_id'] = this.compId;
    data['comp_type'] = this.compType;
    data['comp_status'] = this.compStatus;
    data['comp_regdate'] = this.compRegdate;
    data['complaint_note'] = this.complaintNote;
    data['tech_name'] = this.techName;
    return data;
  }
}
