class SubmitComplaintResponse {
  int? error;
  int? sessionExists;

  SubmitComplaintResponse({this.error, this.sessionExists});

  SubmitComplaintResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    sessionExists = json['session_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['session_exists'] = this.sessionExists;
    return data;
  }
}
