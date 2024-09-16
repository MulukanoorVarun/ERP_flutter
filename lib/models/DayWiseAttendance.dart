class AttendanceDaywiseResponse {
  String? date;
  String? intime;
  String? outtime;
  String? inlocation;
  dynamic? outlocation;
  String? latePenalties;
  int? sessionExists;

  AttendanceDaywiseResponse(
      {this.date,
        this.intime,
        this.outtime,
        this.inlocation,
        this.outlocation,
        this.latePenalties,
        this.sessionExists});

  AttendanceDaywiseResponse.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    intime = json['intime'];
    outtime = json['outtime'];
    inlocation = json['inlocation'];
    outlocation = json['outlocation'];
    latePenalties = json['late_penalties'];
    sessionExists = json['session_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['intime'] = this.intime;
    data['outtime'] = this.outtime;
    data['inlocation'] = this.inlocation;
    data['outlocation'] = this.outlocation;
    data['late_penalties'] = this.latePenalties;
    data['session_exists'] = this.sessionExists;
    return data;
  }
}