class ViewVisitDetailsResponse {
  Complaintdetails? complaintDetails;
  int? error;
  int? sessionExists;

  ViewVisitDetailsResponse(
      {this.complaintDetails, this.error, this.sessionExists});

  ViewVisitDetailsResponse.fromJson(Map<String, dynamic> json) {
    complaintDetails = json['complaint_details'] != null
        ? new Complaintdetails.fromJson(json['complaint_details'])
        : null;
    error = json['error'];
    sessionExists = json['session_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.complaintDetails != null) {
      data['complaint_details'] = this.complaintDetails!.toJson();
    }
    data['error'] = this.error;
    data['session_exists'] = this.sessionExists;
    return data;
  }
}

class Complaintdetails {
  String? id;
  String? oemPemName;
  String? accId;
  String? productId;
  String? genHashId;
  String? engineModel;
  String? alt;
  String? engineNo;
  String? altNo;
  String? invNo;
  String? dgSetNo;
  String? btryNo;
  String? state;
  String? district;
  String? address;
  String? branchId;
  String? salesEmpId;
  String? dispDate;
  String? cmsngDate;
  String? dateOfEngineSale;
  String? pdiDate;
  String? wrntyExpiryDate;
  String? nextService;
  String? date;
  String? extra;
  String? status;
  String? dataSource;
  String? refType;
  String? refId;
  String? orderId;
  String? empId;
  String? isSuspense;
  String? loc;
  String? tempLoc;
  String? locStatus;
  String? isExist;
  String? delRemarks;
  String? delEmpId;
  String? delDatetime;
  String? cname;
  String? mob1;
  String? mob2;
  String? mail;
  String? aname;
  String? emodel;
  String? spname;
  String? complaintId;
  String? openedDate;
  String? dateOfSupply;
  String? complaintType;
  String? complaintCategory;
  String? complaintDesc;

  Complaintdetails(
      {this.id,
        this.oemPemName,
        this.accId,
        this.productId,
        this.genHashId,
        this.engineModel,
        this.alt,
        this.engineNo,
        this.altNo,
        this.invNo,
        this.dgSetNo,
        this.btryNo,
        this.state,
        this.district,
        this.address,
        this.branchId,
        this.salesEmpId,
        this.dispDate,
        this.cmsngDate,
        this.dateOfEngineSale,
        this.pdiDate,
        this.wrntyExpiryDate,
        this.nextService,
        this.date,
        this.extra,
        this.status,
        this.dataSource,
        this.refType,
        this.refId,
        this.orderId,
        this.empId,
        this.isSuspense,
        this.loc,
        this.tempLoc,
        this.locStatus,
        this.isExist,
        this.delRemarks,
        this.delEmpId,
        this.delDatetime,
        this.cname,
        this.mob1,
        this.mob2,
        this.mail,
        this.aname,
        this.emodel,
        this.spname,
        this.complaintId,
        this.openedDate,
        this.dateOfSupply,
        this.complaintType,
        this.complaintCategory,
        this.complaintDesc});

  Complaintdetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oemPemName = json['oem_pem_name'];
    accId = json['acc_id'];
    productId = json['product_id'];
    genHashId = json['gen_hash_id'];
    engineModel = json['engine_model'];
    alt = json['alt'];
    engineNo = json['engine_no'];
    altNo = json['alt_no'];
    invNo = json['inv_no'];
    dgSetNo = json['dg_set_no'];
    btryNo = json['btry_no'];
    state = json['state'];
    district = json['district'];
    address = json['address'];
    branchId = json['branch_id'];
    salesEmpId = json['sales_emp_id'];
    dispDate = json['disp_date'];
    cmsngDate = json['cmsng_date'];
    dateOfEngineSale = json['date_of_engine_sale'];
    pdiDate = json['pdi_date'];
    wrntyExpiryDate = json['wrnty_expiry_date'];
    nextService = json['next_service'];
    date = json['date'];
    extra = json['extra'];
    status = json['status'];
    dataSource = json['data_source'];
    refType = json['ref_type'];
    refId = json['ref_id'];
    orderId = json['order_id'];
    empId = json['emp_id'];
    isSuspense = json['is_suspense'];
    loc = json['loc'];
    tempLoc = json['temp_loc'];
    locStatus = json['loc_status'];
    isExist = json['is_exist'];
    delRemarks = json['del_remarks'];
    delEmpId = json['del_emp_id'];
    delDatetime = json['del_datetime'];
    cname = json['cname'];
    mob1 = json['mob1'];
    mob2 = json['mob2'];
    mail = json['mail'];
    aname = json['aname'];
    emodel = json['emodel'];
    spname = json['spname'];
    complaintId = json['complaint_id'];
    openedDate = json['opened_date'];
    dateOfSupply = json['date_of_supply'];
    complaintType = json['complaint_type'];
    complaintCategory = json['complaint_category'];
    complaintDesc = json['complaint_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['oem_pem_name'] = this.oemPemName;
    data['acc_id'] = this.accId;
    data['product_id'] = this.productId;
    data['gen_hash_id'] = this.genHashId;
    data['engine_model'] = this.engineModel;
    data['alt'] = this.alt;
    data['engine_no'] = this.engineNo;
    data['alt_no'] = this.altNo;
    data['inv_no'] = this.invNo;
    data['dg_set_no'] = this.dgSetNo;
    data['btry_no'] = this.btryNo;
    data['state'] = this.state;
    data['district'] = this.district;
    data['address'] = this.address;
    data['branch_id'] = this.branchId;
    data['sales_emp_id'] = this.salesEmpId;
    data['disp_date'] = this.dispDate;
    data['cmsng_date'] = this.cmsngDate;
    data['date_of_engine_sale'] = this.dateOfEngineSale;
    data['pdi_date'] = this.pdiDate;
    data['wrnty_expiry_date'] = this.wrntyExpiryDate;
    data['next_service'] = this.nextService;
    data['date'] = this.date;
    data['extra'] = this.extra;
    data['status'] = this.status;
    data['data_source'] = this.dataSource;
    data['ref_type'] = this.refType;
    data['ref_id'] = this.refId;
    data['order_id'] = this.orderId;
    data['emp_id'] = this.empId;
    data['is_suspense'] = this.isSuspense;
    data['loc'] = this.loc;
    data['temp_loc'] = this.tempLoc;
    data['loc_status'] = this.locStatus;
    data['is_exist'] = this.isExist;
    data['del_remarks'] = this.delRemarks;
    data['del_emp_id'] = this.delEmpId;
    data['del_datetime'] = this.delDatetime;
    data['cname'] = this.cname;
    data['mob1'] = this.mob1;
    data['mob2'] = this.mob2;
    data['mail'] = this.mail;
    data['aname'] = this.aname;
    data['emodel'] = this.emodel;
    data['spname'] = this.spname;
    data['complaint_id'] = this.complaintId;
    data['opened_date'] = this.openedDate;
    data['date_of_supply'] = this.dateOfSupply;
    data['complaint_type'] = this.complaintType;
    data['complaint_category'] = this.complaintCategory;
    data['complaint_desc'] = this.complaintDesc;
    return data;
  }
}
