class PaymentCollectionWalletResponse {
  TotalDet? totalDet;
  List<HistoryList>? historyList;
  int? error;
  int? sessionExists;

  PaymentCollectionWalletResponse(
      {this.totalDet, this.historyList, this.error, this.sessionExists});

  PaymentCollectionWalletResponse.fromJson(Map<String, dynamic> json) {
    totalDet = json['total_det'] != null
        ? new TotalDet.fromJson(json['total_det'])
        : null;
    if (json['history_list'] != null) {
      historyList = <HistoryList>[];
      json['history_list'].forEach((v) {
        historyList!.add(new HistoryList.fromJson(v));
      });
    }
    error = json['error'];
    sessionExists = json['session_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.totalDet != null) {
      data['total_det'] = this.totalDet!.toJson();
    }
    if (this.historyList != null) {
      data['history_list'] = this.historyList!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['session_exists'] = this.sessionExists;
    return data;
  }
}

class TotalDet {
  String? creditAmount;
  String? debitAmount;
  String? balanceAmount;

  TotalDet({this.creditAmount, this.debitAmount, this.balanceAmount});

  TotalDet.fromJson(Map<String, dynamic> json) {
    creditAmount = json['credit_amount'];
    debitAmount = json['debit_amount'];
    balanceAmount = json['balance_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['credit_amount'] = this.creditAmount;
    data['debit_amount'] = this.debitAmount;
    data['balance_amount'] = this.balanceAmount;
    return data;
  }
}

class HistoryList {
  String? id;
  String? transactionType;
  String? description;
  String? amount;
  String? datetime;

  HistoryList(
      {this.id,
        this.transactionType,
        this.description,
        this.amount,
        this.datetime});

  HistoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionType = json['transaction_type'];
    description = json['description'];
    amount = json['amount'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_type'] = this.transactionType;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['datetime'] = this.datetime;
    return data;
  }
}
