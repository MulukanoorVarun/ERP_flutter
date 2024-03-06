class UpdateComplaintResponse {
  int? error;
  String? fsrFileName;
  int? sessionExists;

  UpdateComplaintResponse({this.error, this.fsrFileName, this.sessionExists});

  UpdateComplaintResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    fsrFileName = json['fsr_file_name'];
    sessionExists = json['session_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['fsr_file_name'] = this.fsrFileName;
    data['session_exists'] = this.sessionExists;
    return data;
  }
}
