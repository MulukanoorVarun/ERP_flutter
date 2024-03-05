class PaymentCollectionResponse {
  List<PC_List>? list;
  int? error;
  int? sessionExists;

  PaymentCollectionResponse({this.list, this.error, this.sessionExists});

  PaymentCollectionResponse.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <PC_List>[];
      json['list'].forEach((v) {
        list!.add(new PC_List.fromJson(v));
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

class PC_List {
  String? accountName;
  String? amount;
  String? paymentMode;
  String? paymentRefNo;
  String? paymentProofFilePath;
  String? paymentProofViewFileName;
  String? approvalStatus;

  PC_List(
      {this.accountName,
        this.amount,
        this.paymentMode,
        this.paymentRefNo,
        this.paymentProofFilePath,
        this.paymentProofViewFileName,
        this.approvalStatus});

  PC_List.fromJson(Map<String, dynamic> json) {
    accountName = json['account_name'];
    amount = json['amount'];
    paymentMode = json['payment_mode'];
    paymentRefNo = json['payment_ref_no'];
    paymentProofFilePath = json['payment_proof_file_path'];
    paymentProofViewFileName = json['payment_proof_view_file_name'];
    approvalStatus = json['approval_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_name'] = this.accountName;
    data['amount'] = this.amount;
    data['payment_mode'] = this.paymentMode;
    data['payment_ref_no'] = this.paymentRefNo;
    data['payment_proof_file_path'] = this.paymentProofFilePath;
    data['payment_proof_view_file_name'] = this.paymentProofViewFileName;
    data['approval_status'] = this.approvalStatus;
    return data;
  }
}
