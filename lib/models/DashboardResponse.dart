class DashboardResponse {
  int? attStatus;
  String? appRequestAutostart;
  String? notificationsCount;
  int? sessionExists;

  DashboardResponse(
      {this.attStatus,
        this.appRequestAutostart,
        this.notificationsCount,
        this.sessionExists});

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    attStatus = json['att_status'];
    appRequestAutostart = json['app_request_autostart'];
    notificationsCount = json['notifications_count'];
    sessionExists = json['session_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['att_status'] = this.attStatus;
    data['app_request_autostart'] = this.appRequestAutostart;
    data['notifications_count'] = this.notificationsCount;
    data['session_exists'] = this.sessionExists;
    return data;
  }
}
