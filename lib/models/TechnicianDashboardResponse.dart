class TechnicianResponse {
  int? avgRating;
  int? pendingComplaints;
  int? todayVisits;
  int? thisMonthsVisits;
  String? paymentCollectionWalletBalanceAmount;
  String? monthlyPaymentCollectionAmount;
  int? error;
  int? sessionExists;

  TechnicianResponse(
      {this.avgRating,
        this.pendingComplaints,
        this.todayVisits,
        this.thisMonthsVisits,
        this.paymentCollectionWalletBalanceAmount,
        this.monthlyPaymentCollectionAmount,
        this.error,
        this.sessionExists});

  TechnicianResponse.fromJson(Map<String, dynamic> json) {
    avgRating = json['avg_rating'];
    pendingComplaints = json['pending_complaints'];
    todayVisits = json['today_visits'];
    thisMonthsVisits = json['this_months_visits'];
    paymentCollectionWalletBalanceAmount =
    json['payment_collection_wallet_balance_amount'];
    monthlyPaymentCollectionAmount = json['monthly_payment_collection_amount'];
    error = json['error'];
    sessionExists = json['session_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avg_rating'] = this.avgRating;
    data['pending_complaints'] = this.pendingComplaints;
    data['today_visits'] = this.todayVisits;
    data['this_months_visits'] = this.thisMonthsVisits;
    data['payment_collection_wallet_balance_amount'] =
        this.paymentCollectionWalletBalanceAmount;
    data['monthly_payment_collection_amount'] =
        this.monthlyPaymentCollectionAmount;
    data['error'] = this.error;
    data['session_exists'] = this.sessionExists;
    return data;
  }
}