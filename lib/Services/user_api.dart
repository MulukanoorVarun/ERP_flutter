import 'dart:convert';
import 'dart:io';
import 'package:GenERP/models/AccountSuggestionResponse.dart';
import 'package:GenERP/models/DashboardResponse.dart';
import 'package:GenERP/models/LogoutResponse.dart';
import 'package:GenERP/models/ProfileResponse.dart';
import 'package:GenERP/models/SessionResponse.dart';
import 'package:GenERP/models/StatusResponse.dart';
import 'package:GenERP/models/TagGeneratorResponse.dart';
import 'package:GenERP/models/TagLocationResponse.dart';
import 'package:GenERP/models/TechnicianDashboardResponse.dart';
import 'package:GenERP/models/TechniciansPendingComplaintsResponse.dart';
import 'package:GenERP/models/UpdatePasswordResponse.dart';
import 'package:GenERP/models/VersionsResponse.dart';
import 'package:GenERP/models/generatorComplaintResponse.dart';
import 'package:GenERP/models/loadGeneratorDetailsResponse.dart';
import 'package:GenERP/screens/GenTechnicianModule/AccountSuggestion.dart';
import 'package:flutter/cupertino.dart';
import '../Utils/api_names.dart';
import '../models/AddContactResponse.dart';
import '../models/AttendanceHistoryresponse.dart';
import '../models/AttendanceListResponse.dart';
import '../models/CheckInResponse.dart';
import '../models/CheckOutResponse.dart';
import '../models/ComplaintsSelectionResponse.dart';
import '../models/DayWiseAttendance.dart';
import '../models/FollowUpResponse.dart';
import '../models/Inventory_Part_details_response.dart';
import '../models/LoginQRResponse.dart';
import '../models/NearbyGeneratorsResponse.dart';
import '../models/PaymentCollectionResponse.dart';
import '../models/PaymentCollectionValidateOTPResponse.dart';
import '../models/PaymentCollectionWalletResponse.dart';
import '../models/SubmitComplaintResponse.dart';
import '../models/TechnicianAddPaymentCollectionResponse.dart';
import '../models/TechnicianLoadNumbersResponse.dart';
import '../models/TodayVisitResponse.dart';
import '../models/UpdateComplaintResponse.dart';
import '../models/ViewVisitDetailsResponse.dart';
import 'api_calls.dart';
import 'other_services.dart';
class UserApi {

  static Future<VersionsResponse?> versionApi() async {
    try {
      final res = await post({}, getUpdateStatus, {});
      if (res != null) {
        print(res.body);

        return VersionsResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<StatusResponse?> LoginFunctionApi(email, password, token,
      deviceID, deviceInfo) async {
    try {
      Map<String, String> data = {
        'email_id': (email).toString(),
        'password': (password).toString(),
        'token_id': (token).toString(),
        'device_id': (deviceID).toString(),
        'device_details': (deviceInfo).toString()
      };
      final res = await post(data, getLoginStatus, {});
      if (res != null) {
        print(res.body);

        return StatusResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future download_files(empId, session,url,cntxt) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
      };
      final res = await post(data, url, {});
      if (res != null) {
        final bytes = res.bodyBytes;
        final directory = "/storage/emulated/0/Download";



        final contentDisposition = res.headers['content-disposition'];
        print("contentDisposition ${contentDisposition?.split('filename=')[1]}");

        // final filename = contentDisposition != null
        //     ? contentDisposition.split('filename=')[1]
        //     : 'file';
        var filename=(contentDisposition?.split('filename=')[1])?.replaceAll('"', "");
        final file = File('${directory}/${filename}');
        await file.writeAsBytes(bytes);
        toast(cntxt, "File saved to your downloads as ${filename}, Successfully");
        print('File saved successfully');
        return  jsonDecode(res.body);
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<DashboardResponse?> DashboardFunctionApi(empId, session) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
      };
      final res = await post(data, getDashboardStatus, {});
      if (res != null) {
        print(res.body);

        return DashboardResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<ProfileResponse?> ProfileFunctionApi(empId, session) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
      };
      final res = await post(data, loadProfileDetails, {});
      if (res != null) {
        print(res.body);

        return ProfileResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<LogoutResponse?> LogoutFunctionApi(empId, session) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
      };
      final res = await post(data, getLogoutStatus, {});
      if (res != null) {
        print(res.body);

        return LogoutResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }


  static Future<CheckInResponse?> CheckInApi(empId, sessioId, location, latlngs,
      check_in_pic) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (sessioId).toString(),
        'posit': (latlngs).toString(),
        'location': (location).toString(),

      };
      var res;
      if (check_in_pic != null) {
        res = await postImage(data, checkInapi, {}, check_in_pic);
        res = jsonDecode(res);
      } else {
        res = await post(data, checkInapi, {});
        res = jsonDecode(res);
      }
      if (res != null) {
        print(res);
        return CheckInResponse.fromJson(res);
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<CheckOutResponse?> CheckOutApi(empId, sessioId, location,
      latlngs, image) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (sessioId).toString(),
        'location': (location).toString(),
        'posit': (latlngs).toString(),

      };
      var res;
      if (image != null) {
        res = await postImage2(data, {}, checkOutapi, image);
        res = jsonDecode(res);
      } else {
        res = await post(data, checkOutapi, {});
        res = jsonDecode(res);
      }
      if (res != null) {
        print(res);
        return CheckOutResponse.fromJson(res);
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }


  static Future<AttendanceDashboard?> AttendanceListApi(empId, session) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
      };
      final res = await post(data, attendanceListapi, {});
      if (res != null) {
        print(res.body);
        return AttendanceDashboard.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static LoadAttendanceDetails(empId, session, month, year) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'year': (year).toString(),
        'month': month.toString()
      };
      final res = await post(data, loadAttendanceDetailsapi, {});
      if (res != null) {
        print(res.body);
        // return AttendanceHistory.fromJson(jsonDecode(res.body));
        return res.body;
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<AttendanceDaywiseResponse?> DateWiseAttendanceApi(empId,
      session, date) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'date': (date).toString(),
      };
      final res = await post(data, DayAttendanceDetailsapi, {});
      if (res != null) {
        print(res.body);
        return AttendanceDaywiseResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<SessionResponse?> SessionExistsApi(empId, session) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
      };
      final res = await post(data, getSessionExistsApi, {});
      if (res != null) {
        print(res.body);
        return SessionResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<UpdatePasswordResponse?> UpdatePasswordApi(empId, session,
      password, conf_password) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'password': (password).toString(),
        'confirm_password': (conf_password).toString()
      };
      final res = await post(data, updatePassword, {});
      if (res != null) {
        print(res.body);
        return UpdatePasswordResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<loadGeneratorDetailsResponse?> LoadGeneratorDetailsAPI(empId,
      session, gen_hash_id) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'gen_hash_id':(gen_hash_id).toString(),

      };
      final res = await post(data, loadGeneratorDetails, {});
      if (res != null) {
        print(res.body);
        return loadGeneratorDetailsResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }


  static Future<loadGeneratorDetailsResponse?> LoadTechnicianGeneratorDetailsAPI(empId,
      session, gen_id) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'gen_id':(gen_id).toString(),

      };
      final res = await post(data, technician_generator_detailsAPI, {});
      if (res != null) {
        print(res.body);
        return loadGeneratorDetailsResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<generatorComplaintResponse?> LoadGeneratorComplaintListAPI(
      empId, session, gen_id, open_status) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'gen_id': (gen_id).toString(),
        'open_status': (open_status).toString()
      };
      final res = await post(data, getComplaintHistoryList, {});
      if (res != null) {
        print(res.body);
        return generatorComplaintResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<TagLocationResponse?> TagLocationAPI(empId, session,
      gen_hash_id, location) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'gen_hash_id': (gen_hash_id).toString(),
        'location': (location).toString()
      };
      final res = await post(data, tagLocation, {});
      if (res != null) {
        print(res.body);
        return TagLocationResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<TagGeneratorResponse?> TagGeneratorAPI(empId, session,
      gen_hash_id, engine_no) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'gen_hash_id':(gen_hash_id).toString(),
        'engine_no':(engine_no).toString()

      };
      final res = await post(data,tagGenerator, {});
      if (res != null) {
        print(res.body);
        return TagGeneratorResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<SubmitComplaintResponse?> SubmitGeneratorComplaintAPI(empId,session,complaint_type_id,complaint_category_id,complaint_desc_id,running_hrs,gen_id,complaint_note) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'complaint_type_id':(complaint_type_id).toString(),
        'complaint_category_id':(complaint_category_id).toString(),
        'complaint_desc_id':(complaint_desc_id).toString(),
        'running_hrs':(running_hrs).toString(),
        'gen_id':(gen_id).toString(),
        'complaint_note':(complaint_note).toString()
      };
      final res = await post(data,submitComplaint, {});
      if (res != null) {
        print(res.body);
        return SubmitComplaintResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<ComplaintsSelectionResponse?> ComplaintSelectionAPI(empId,session,gen_hash_id) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'gen_hash_id':(gen_hash_id).toString(),

      };
      final res = await post(data,ComplaintsSelection, {});
      if (res != null) {
        print(res.body);
        return ComplaintsSelectionResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<LoginQRResponse?> QRLoginRequestAPI(empId,session,type,token) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'type':(type).toString(),
        'token':(token).toString(),

      };
      final res = await post(data,qrLoginRequest, {});
      if (res != null) {
        print(res.body);
        return LoginQRResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  ///Inventory Module API's


  static Future<Inventory_Part_details_response?> LoadPartDetailsAPI(empId,session,part_id) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'part_id':(part_id).toString(),

      };
      final res = await post(data,inventory_part_detailsAPI, {});
      if (res != null) {
        print(res.body);
        return Inventory_Part_details_response.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }


  static Future<loadGeneratorDetailsResponse?>InventoryUpdateStockAPI(empId,session,qty,descr,part_id,tran_type) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'qty': (qty).toString(),
        'descr': (descr).toString(),
        'product_id':(part_id).toString(),
        'tran_type':(tran_type).toString(),

      };
      final res = await post(data,inventory_stock_updateAPI, {});
      if (res != null) {
        print(res.body);
        return loadGeneratorDetailsResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }


  static Future<TechnicianResponse?> loadTechnicianDashboardApi(empId,
      session) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
      };
      final res = await post(data, technician_dashboardAPI, {});
      if (res != null) {
        print(res.body);
        return TechnicianResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<TodayVisitResponse?> getTodayVisitsListAPI(empId,
      session) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
      };
      final res = await post(data, technician_todays_visitsAPI, {});
      if (res != null) {
        print(res.body);
        return TodayVisitResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }


  static Future<TodayVisitResponse?> getMonthVisitsListAPI(empId,
      session) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
      };
      final res = await post(data, technician_monthly_visitsAPI, {});
      if (res != null) {
        print(res.body);
        return TodayVisitResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }


  static Future<NearbyGeneratorsResponse?> loadNearbyGeneratorsAPI(empId, session,tech_loc,radius) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'tech_loc': (tech_loc).toString(),
        'radius': (radius).toString(),
      };
      final res = await post(data, technician_nearby_generatorsAPI, {});
      if (res != null) {
        print(res.body);
        return NearbyGeneratorsResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<AccountSuggestionResonse?> AccountSuggestionAPI(empId, session,
      search_string) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'search_string': (search_string).toString(),


      };
      final res = await post(data, getAccountSuggestions, {});
      if (res != null) {
        print(res.body);
        return AccountSuggestionResonse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<
      TechnicianPendingComplaintsResponse?> LoadTechnicianComplaintsAPI(empId,
      session) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
      };
      final res = await post(data, getPendingComplaintsList, {});
      if (res != null) {
        print(res.body);
        return TechnicianPendingComplaintsResponse.fromJson(
            jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<TechnicianLoadNumbersResponse?> LoadContactsTechnicianAPI(empId,
      session, type, gen_id, account_id) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'type': (type).toString(),
        'gen_id': (gen_id).toString(),
        'account_id': (account_id).toString(),
      };
      final res = await post(data, loadNumbersApi, {});
      if (res != null) {
        print(res.body);
        return TechnicianLoadNumbersResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<
      TechnicianAddPaymentCollectionResponse?> TechnicianUpdatepaymentAPI(empId,
      session, ref_type, ref_id, payment_mode_id, payment_ref_no, amount,
      otp_validated_name, otp_validated_mobile_number, payment_proof) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'ref_type': (ref_type).toString(),
        'ref_id': (ref_id).toString(),
        'payment_mode_id': (payment_mode_id).toString(),
        'payment_ref_no': (payment_ref_no).toString(),
        'amount': (amount).toString(),
        'otp_validated_name': (otp_validated_name).toString(),
        'otp_validated_mobile_number': (otp_validated_mobile_number).toString(),

      };
      var res;
      if (payment_proof != null) {
        res = await postImage3(data, {},updatePaymentDetails, payment_proof);
        res = jsonDecode(res);
      } else {
        res = await post(data, checkInapi, {});
        res = jsonDecode(res);
      }
      if (res != null) {
        print(res);
        return TechnicianAddPaymentCollectionResponse.fromJson(res);
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<
      PaymentCollectionValidateOTPResponse?> TechnicianPaymentOTPValidateAPI(
      empId, session, payment_collection_id, otp) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'payment_collection_id': (payment_collection_id).toString(),
        'otp': (otp).toString(),

      };
      final res = await post(data, validateOTPApi, {});
      if (res != null) {
        print(res.body);
        return PaymentCollectionValidateOTPResponse.fromJson(
            jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<PaymentCollectionResponse?> paymentCollectionListAPI(empId,
      session,) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
      };
      final res = await post(data, paymentCollectionListApi, {});
      if (res != null) {
        print(res.body);
        return PaymentCollectionResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }


  static Future<PaymentCollectionWalletResponse?>loadTransactionsListAPI(empId,session) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
      };
      final res = await post(data,loadTransactionsListApi, {});
      if (res != null) {
        print(res.body);
        return PaymentCollectionWalletResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<ViewVisitDetailsResponse?> loadVisitDetailsAPI(empId, session, comp_id) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'comp_id':(comp_id).toString(),
      };
      final res = await post(data, technician_complaint_detailsAPI, {});
      if (res != null) {
        print(res.body);
        return ViewVisitDetailsResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<FollowupListResponse?>loadFollowupListAPI(empId, session, comp_id) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'comp_id':(comp_id).toString(),
      };
      final res = await post(data, technician_complaint_followup_listAPI, {});
      if (res != null) {
        print(res.body);
        return FollowupListResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<AddContactResponse?> AddContactAPI(empId, session, gen_id, name,
      designation, mob1, mob2, tel, mail, type, account_id) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'gen_id': (gen_id).toString(),
        'name': (name).toString(),
        'designation': (designation).toString(),
        'mob1': (mob1).toString(),
        'mob2': (mob2).toString(),
        'tel': (tel).toString(),
        'mail': (mail).toString(),
        'type': (type).toString(),
        'account_id': (account_id).toString(),
      };
      final res = await post(data, saveContactApi, {});
      if (res != null) {
        print(res.body);
        return AddContactResponse.fromJson(jsonDecode(res.body));
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }

  static Future<UpdateComplaintResponse?> UpdateComplaintAPI(empId, session,
      complaint_id, in_time, feedback, fsr_no, running_hrs, complaint_status,
      fsr_file) async {
    try {
      Map<String, String> data = {
        'emp_id': (empId).toString(),
        'session_id': (session).toString(),
        'complaint_id': (complaint_id).toString(),
        'in_time': (in_time).toString(),
        'feedback': (feedback).toString(),
        'fsr_no': (fsr_no).toString(),
        'running_hrs': (running_hrs).toString(),
        'complaint_status': (complaint_status).toString(),
      };
      var res;
      if (fsr_file != null) {
        res = await postImage4(data, {}, updateComplaintStatus, fsr_file);
        res = jsonDecode(res);
      } else {
        res = await post(data, checkInapi, {});
        res = jsonDecode(res);
      }
      if (res != null) {
        print(res);
        return UpdateComplaintResponse.fromJson(res);
      } else {
        print("Null Response");
        return null;
      }
    } catch (e) {
      debugPrint('hello bev=bug $e ');
      return null;
    }
  }
}
