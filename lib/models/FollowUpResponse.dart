class FollowupListResponse {
  List<Followuplist>? list;
  int? error;
  int? sessionExists;

  FollowupListResponse({this.list, this.error, this.sessionExists});

  FollowupListResponse.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <Followuplist>[];
      json['list'].forEach((v) {
        list!.add(new Followuplist.fromJson(v));
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

class Followuplist {
  String? id;
  String? empId;
  String? compId;
  String? inTime;
  String? outTime;
  String? feedback;
  String? type;
  String? date;
  String? fsrNo;
  String? fsrExt;
  String? runningHrs;
  String? time;
  String? ename;

  Followuplist(
      {this.id,
        this.empId,
        this.compId,
        this.inTime,
        this.outTime,
        this.feedback,
        this.type,
        this.date,
        this.fsrNo,
        this.fsrExt,
        this.runningHrs,
        this.time,
        this.ename});

  Followuplist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    empId = json['emp_id'];
    compId = json['comp_id'];
    inTime = json['in_time'];
    outTime = json['out_time'];
    feedback = json['feedback'];
    type = json['type'];
    date = json['date'];
    fsrNo = json['fsr_no'];
    fsrExt = json['fsr_ext'];
    runningHrs = json['running_hrs'];
    time = json['time'];
    ename = json['ename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emp_id'] = this.empId;
    data['comp_id'] = this.compId;
    data['in_time'] = this.inTime;
    data['out_time'] = this.outTime;
    data['feedback'] = this.feedback;
    data['type'] = this.type;
    data['date'] = this.date;
    data['fsr_no'] = this.fsrNo;
    data['fsr_ext'] = this.fsrExt;
    data['running_hrs'] = this.runningHrs;
    data['time'] = this.time;
    data['ename'] = this.ename;
    return data;
  }
}
