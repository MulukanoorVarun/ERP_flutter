
class ProfileResponse {
  String? totpSecret;
  String? empId;
  String? empName;
  String? emailId;
  String? branchName;
  String? mobileNo;
  String? designation;
  String? company;
  String? profilePic;
  int? sessionExists;

  ProfileResponse(
      {this.totpSecret,
        this.empId,
        this.empName,
        this.emailId,
        this.branchName,
        this.mobileNo,
        this.designation,
        this.company,
        this.profilePic,
        this.sessionExists});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    totpSecret = json['totp_secret'];
    empId = json['emp_id'];
    empName = json['emp_name'];
    emailId = json['email_id'];
    branchName = json['branch_name'];
    mobileNo = json['mobile_no'];
    designation = json['designation'];
    company = json['company'];
    profilePic = json['profile_pic'];
    sessionExists = json['session_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totp_secret'] = this.totpSecret;
    data['emp_id'] = this.empId;
    data['emp_name'] = this.empName;
    data['email_id'] = this.emailId;
    data['branch_name'] = this.branchName;
    data['mobile_no'] = this.mobileNo;
    data['designation'] = this.designation;
    data['company'] = this.company;
    data['profile_pic'] = this.profilePic;
    data['session_exists'] = this.sessionExists;
    return data;
  }
}
