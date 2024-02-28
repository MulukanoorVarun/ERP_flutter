class StatusResponse {
  int? error;
  String? ccsUsername;
  String? ccsPassword;
  String? ccsPbxDomain;
  String? ccsPbxSipProtocol;
  String? sessionId;
  String? userId;
  String? name;
  String? emailId;
  List<String>? permissions;
  int? attStatus;
  String? appRequestAutostart;
  String? notificationsCount;
  int? sessionExists;

  StatusResponse(
      {this.error,
        this.ccsUsername,
        this.ccsPassword,
        this.ccsPbxDomain,
        this.ccsPbxSipProtocol,
        this.sessionId,
        this.userId,
        this.name,
        this.emailId,
        this.permissions,
        this.attStatus,
        this.appRequestAutostart,
        this.notificationsCount,
        this.sessionExists});

  StatusResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    ccsUsername = json['ccs_username'];
    ccsPassword = json['ccs_password'];
    ccsPbxDomain = json['ccs_pbx_domain'];
    ccsPbxSipProtocol = json['ccs_pbx_sip_protocol'];
    sessionId = json['session_id'];
    userId = json['user_id'];
    name = json['name'];
    emailId = json['email_id'];
    permissions = json['permissions'].cast<String>();
    attStatus = json['att_status'];
    appRequestAutostart = json['app_request_autostart'];
    notificationsCount = json['notifications_count'];
    sessionExists = json['session_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['ccs_username'] = this.ccsUsername;
    data['ccs_password'] = this.ccsPassword;
    data['ccs_pbx_domain'] = this.ccsPbxDomain;
    data['ccs_pbx_sip_protocol'] = this.ccsPbxSipProtocol;
    data['session_id'] = this.sessionId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email_id'] = this.emailId;
    data['permissions'] = this.permissions;
    data['att_status'] = this.attStatus;
    data['app_request_autostart'] = this.appRequestAutostart;
    data['notifications_count'] = this.notificationsCount;
    data['session_exists'] = this.sessionExists;
    return data;
  }
}
