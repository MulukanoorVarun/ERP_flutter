class AttendanceDashboard {
  int? attStatus;
  List<AttHistory>? attHistory;
  int? sessionExists;

  AttendanceDashboard({this.attStatus, this.attHistory, this.sessionExists});

  AttendanceDashboard.fromJson(Map<String, dynamic> json) {
    attStatus = json['att_status'];
    if (json['att_history'] != null) {
      attHistory = <AttHistory>[];
      json['att_history'].forEach((v) {
        attHistory!.add(new AttHistory.fromJson(v));
      });
    }
    sessionExists = json['session_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['att_status'] = this.attStatus;
    if (this.attHistory != null) {
      data['att_history'] = this.attHistory!.map((v) => v.toJson()).toList();
    }
    data['session_exists'] = this.sessionExists;
    return data;
  }
}

class AttHistory {
  String? date;
  String? checkInTime;
  String? checkOutTime;

  AttHistory({this.date, this.checkInTime, this.checkOutTime});

  AttHistory.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    checkInTime = json['check_in_time'];
    checkOutTime = json['check_out_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['check_in_time'] = this.checkInTime;
    data['check_out_time'] = this.checkOutTime;
    return data;
  }
}