class TechnicianAddPaymentCollectionResponse {
  int? paymentCollectionId;
  int? error;
  String? message;
  int? sessionExists;

  TechnicianAddPaymentCollectionResponse(
      {this.paymentCollectionId, this.error, this.message, this.sessionExists});

  TechnicianAddPaymentCollectionResponse.fromJson(Map<String, dynamic> json) {
    paymentCollectionId = json['payment_collection_id'];
    error = json['error'];
    message = json['message'];
    sessionExists = json['session_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_collection_id'] = this.paymentCollectionId;
    data['error'] = this.error;
    data['message'] = this.message;
    data['session_exists'] = this.sessionExists;
    return data;
  }
}
