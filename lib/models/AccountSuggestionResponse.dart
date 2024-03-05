class AccountSuggestionResonse {
  List<AccountList>? accountList;
  int? error;
  int? sessionExists;

  AccountSuggestionResonse({this.accountList, this.error, this.sessionExists});

  AccountSuggestionResonse.fromJson(Map<String, dynamic> json) {
    if (json['account_list'] != null) {
      accountList = <AccountList>[];
      json['account_list'].forEach((v) {
        accountList!.add(new AccountList.fromJson(v));
      });
    }
    error = json['error'];
    sessionExists = json['session_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.accountList != null) {
      data['account_list'] = this.accountList!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['session_exists'] = this.sessionExists;
    return data;
  }
}

class AccountList {
  String? accountName;
  String? accountId;

  AccountList({this.accountName, this.accountId});

  AccountList.fromJson(Map<String, dynamic> json) {
    accountName = json['account_name'];
    accountId = json['account_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_name'] = this.accountName;
    data['account_id'] = this.accountId;
    return data;
  }
}
