class Inventory_Part_details_response {
  int? error;
  PartData? partData;
  int? sessionExists;

  Inventory_Part_details_response(
      {this.error, this.partData, this.sessionExists});

  Inventory_Part_details_response.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    partData = json['part_data'] != null
        ? new PartData.fromJson(json['part_data'])
        : null;
    sessionExists = json['session_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.partData != null) {
      data['part_data'] = this.partData!.toJson();
    }
    data['session_exists'] = this.sessionExists;
    return data;
  }
}

class PartData {
  String? id;
  String? productCode;
  String? project;
  String? subGroup;
  String? vendor1;
  String? vendor2;
  String? vendorCode;
  String? prodName;
  String? brand;
  String? imageDirFilePath;
  String? imageViewFileName;
  String? prodDesc;
  String? hsnCode;
  String? units;
  String? unitsId;
  String? worksMsl;
  String? refType;
  String? refId;
  String? price;
  String? type;
  String? productionProcessId;
  String? createdBy;
  String? datetime;
  String? isExists;
  String? updatedDatetime;
  String? msl;
  int? remainingQuantity;
  String? branchName;

  PartData(
      {this.id,
        this.productCode,
        this.project,
        this.subGroup,
        this.vendor1,
        this.vendor2,
        this.vendorCode,
        this.prodName,
        this.brand,
        this.imageDirFilePath,
        this.imageViewFileName,
        this.prodDesc,
        this.hsnCode,
        this.units,
        this.unitsId,
        this.worksMsl,
        this.refType,
        this.refId,
        this.price,
        this.type,
        this.productionProcessId,
        this.createdBy,
        this.datetime,
        this.isExists,
        this.updatedDatetime,
        this.msl,
        this.remainingQuantity,
        this.branchName});

  PartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productCode = json['product_code'];
    project = json['project'];
    subGroup = json['sub_group'];
    vendor1 = json['vendor_1'];
    vendor2 = json['vendor_2'];
    vendorCode = json['vendor_code'];
    prodName = json['prod_name'];
    brand = json['brand'];
    imageDirFilePath = json['image_dir_file_path'];
    imageViewFileName = json['image_view_file_name'];
    prodDesc = json['prod_desc'];
    hsnCode = json['hsn_code'];
    units = json['units'];
    unitsId = json['units_id'];
    worksMsl = json['works_msl'];
    refType = json['ref_type'];
    refId = json['ref_id'];
    price = json['price'];
    type = json['type'];
    productionProcessId = json['production_process_id'];
    createdBy = json['created_by'];
    datetime = json['datetime'];
    isExists = json['is_exists'];
    updatedDatetime = json['updated_datetime'];
    msl = json['msl'];
    remainingQuantity = json['remaining_quantity'];
    branchName = json['branch_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_code'] = this.productCode;
    data['project'] = this.project;
    data['sub_group'] = this.subGroup;
    data['vendor_1'] = this.vendor1;
    data['vendor_2'] = this.vendor2;
    data['vendor_code'] = this.vendorCode;
    data['prod_name'] = this.prodName;
    data['brand'] = this.brand;
    data['image_dir_file_path'] = this.imageDirFilePath;
    data['image_view_file_name'] = this.imageViewFileName;
    data['prod_desc'] = this.prodDesc;
    data['hsn_code'] = this.hsnCode;
    data['units'] = this.units;
    data['units_id'] = this.unitsId;
    data['works_msl'] = this.worksMsl;
    data['ref_type'] = this.refType;
    data['ref_id'] = this.refId;
    data['price'] = this.price;
    data['type'] = this.type;
    data['production_process_id'] = this.productionProcessId;
    data['created_by'] = this.createdBy;
    data['datetime'] = this.datetime;
    data['is_exists'] = this.isExists;
    data['updated_datetime'] = this.updatedDatetime;
    data['msl'] = this.msl;
    data['remaining_quantity'] = this.remainingQuantity;
    data['branch_name'] = this.branchName;
    return data;
  }
}
