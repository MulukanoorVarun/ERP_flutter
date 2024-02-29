import 'package:GenERP/Utils/storage.dart';

import '../Services/other_services.dart';
import 'Constants.dart';

const baseUrl = "https://erp.gengroup.in/ci/app/";

var Sessionid;
getheader() async {
  Sessionid = await PreferenceService().getString("Session_id");
}
// var NetBankingBanksApiName = "https://api-preprod.phonepe.com/apis/hermes/pg/v1/options/$PhonePeMerchantId";
var WEB_SOCKET_URL = "wss://ws.erp.gengroup.in/?type=user&route=employe_live_location_update&session_id=${Sessionid}";
const getUpdateStatus = "https://erp.gengroup.in/ci/assets/appversion.json";
const getLoginStatus = "${baseUrl}auth/login";
const getDashboardStatus = "${baseUrl}home/emp_dashboard";
const loadProfileDetails = "${baseUrl}home/emp_profile";
const getLogoutStatus = "${baseUrl}home/logout";
const checkInapi = "${baseUrl}home/attendance_check_in";
const checkOutapi = "${baseUrl}home/attendance_check_out";
const attendanceListapi = "${baseUrl}home/attendance_dashboard";
const loadAttendanceDetailsapi = "${baseUrl}home/attendance_monthwise_det";


// const profile_details = "${baseUrl}profile_details";
// const refresh_token_api = "${baseUrl}refresh_customer_token";

