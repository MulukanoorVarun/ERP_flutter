class TagGeneratorResponse {
  int? error;
  String? message;
  int? sessionExists;

  TagGeneratorResponse({this.error, this.message, this.sessionExists});

  TagGeneratorResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    sessionExists = json['session_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    data['session_exists'] = this.sessionExists;
    return data;
  }
}
