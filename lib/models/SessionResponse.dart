class SessionResponse {
  int? updatePasswordRequired;
  int? sessionExists;

  SessionResponse({this.updatePasswordRequired, this.sessionExists});

  SessionResponse.fromJson(Map<String, dynamic> json) {
    updatePasswordRequired = json['update_password_required'];
    sessionExists = json['session_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['update_password_required'] = this.updatePasswordRequired;
    data['session_exists'] = this.sessionExists;
    return data;
  }
}
