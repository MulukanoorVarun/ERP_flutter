import 'dart:convert';
import 'package:GenERP/models/DashboardResponse.dart';
import 'package:GenERP/models/LogoutResponse.dart';
import 'package:GenERP/models/ProfileResponse.dart';
import 'package:GenERP/models/StatusResponse.dart';
import 'package:GenERP/models/VersionsResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../Utils/api_names.dart';
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
  static Future<StatusResponse?> LoginFunctionApi(email,password,token,deviceID,deviceInfo) async {
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

  static Future<DashboardResponse?> DashboardFunctionApi(empId,session) async {
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

  static Future<ProfileResponse?> ProfileFunctionApi(empId,session) async {
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
  static Future<LogoutResponse?> LogoutFunctionApi(empId,session) async {
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



// static Future<CartTotalModel?> CartTotalCountsApi() async {
  //   try {
  //     final header = await HeaderValues();
  //     final res = await post({}, CartTotalCountsApiName, header);
  //     if (res != null) {
  //       return CartTotalModel.fromJson(jsonDecode(res.body));
  //     } else {
  //       print("Null Response");
  //       return null;
  //     }
  //   } catch (e) {
  //     debugPrint('hello bev=bug $e ');
  //     return null;
  //   }
  // }
  //
  // static Future<OtpVerifyModal?> UpdateRefreshToken(token) async {
  //   try {
  //     Map<String, String> data = {
  //       'refresh_token': (token).toString(),
  //     };
  //     final header = await HeaderValues();
  //     final res = await post(data, RefreshTokenApiName, header);
  //     if (res != null) {
  //       return OtpVerifyModal.fromJson(jsonDecode(res.body));
  //     } else {
  //       print("Null Response");
  //       return null;
  //     }
  //   } catch (e) {
  //     debugPrint('hello bev=bug $e ');
  //     return null;
  //   }
  // }
  //
  // static Future<LoginModel?> GenerateOtpApi(mobile, countryId) async {
  //   try {
  //     Map<String, String> data = {
  //       'mobile_number': (mobile).toString(),
  //       'mobile_number_country_id': (countryId).toString()
  //     };
  //     final header = await HeaderValues();
  //     final res = await post(data, GenerateOtpApiName, header);
  //     if (res != null) {
  //       print(res.body);
  //       return LoginModel.fromJson(jsonDecode(res.body));
  //     } else {
  //       print("Null Response");
  //       return null;
  //     }
  //   } catch (e) {
  //     debugPrint('hello bev=bug $e ');
  //     return null;
  //   }
  // }
  //
  // static Future<OtpVerifyModal?> GuestLoginApi() async {
  //   try {
  //     final header = await HeaderValues();
  //     final res = await post({}, GuestLoginApiName, header);
  //     if (res != null) {
  //       return OtpVerifyModal.fromJson(jsonDecode(res.body));
  //     } else {
  //       print("Null Response");
  //       return null;
  //     }
  //   } catch (e) {
  //     debugPrint('hello bev=bug $e ');
  //     return null;
  //   }
  // }
  //
  // static Future<OtpVerifyModal?> VerifyOtpApi(
  //     mobile, otp, countryId, fcmToken) async {
  //   try {
  //     Map<String, String> data = {
  //       'mobile_number': (mobile).toString(),
  //       'otp': (otp).toString(),
  //       'mobile_number_country_id': (countryId).toString(),
  //       'fcm_token': (fcmToken).toString()
  //     };
  //     final header = await HeaderValues();
  //     final res = await post(data, VerifyOtpApiName, header);
  //     if (res != null) {
  //       print(res.body);
  //       return OtpVerifyModal.fromJson(jsonDecode(res.body));
  //     } else {
  //       print("Null Response");
  //       return null;
  //     }
  //   } catch (e) {
  //     debugPrint('hello bev=bug $e ');
  //     return null;
  //   }
  // }
  //
  // static Future<RegisterModel?> RegistrationApi(
  //     mobile, name, emailId, otp, countryId, fcmToken, regType) async {
  //   try {
  //     Map<String, String> data = {
  //       'mobile_number': mobile.toString(),
  //       'email_id': emailId.toString(),
  //       'name': name.toString(),
  //       'mobile_number_country_id': (countryId).toString(),
  //       'otp': otp.toString(),
  //       'fcm_token': (fcmToken).toString(),
  //       'reg_type': regType.toString(),
  //     };
  //     final header = await HeaderValues();
  //
  //     final res = await post(data, RegisterApiName, header);
  //     if (res != null) {
  //       return RegisterModel.fromJson(jsonDecode(res.body));
  //     } else {
  //       print("Null Response");
  //       return null;
  //     }
  //   } catch (e) {
  //     debugPrint('hello bev=bug $e ');
  //     return null;
  //   }
  // }
  //
  //
  // static Future<DashboardModel?> DashboardApi() async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       final header = await HeaderValues();
  //       final res = await post({}, DashboardApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         //  print(jsonDecode(res.body)["bottom_sliders"]);
  //         return DashboardModel.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return DashboardModel(error: "401");
  //   }
  // }
  //
  // static Future<BestSellersModal?> BestSellersApi(pageNum,sortValue,price,brand,stck,dis) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'page_num': pageNum.toString(),
  //         'sort_condition':sortValue,
  //         'price_filter':jsonEncode(price).toString(),
  //         'stock_filter':stck,
  //         'discount_filter':dis,
  //         'brand_filter':jsonEncode(brand).toString()
  //         // 'brand_filter':(jsonEncode(brand_filter).toString()),
  //         // 'discount_filter':discount_filter,
  //         // 'filter':(jsonEncode(price_filter).toString()),
  //         // 'stock_filter':discount_filter,
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, BestSellersApiName, header);
  //       if (res != null && res.body.isNotEmpty) {
  //         print(res.body);
  //         return BestSellersModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return BestSellersModal(error: "401");
  //   }
  // }
  //
  //
  // static Future<NewReleasesModal?> NewReleasesApi(pageNum,sortVal,price,brand,stck,dis) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'page_count': pageNum.toString(),
  //         'sort_condition':sortVal,
  //         'price_filter':jsonEncode(price).toString(),
  //         'stock_filter':stck,
  //         'discount_filter':dis,
  //         'brand_filter':jsonEncode(brand).toString()
  //
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, NewReleasesApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         //  print(jsonDecode(res.body)["bottom_sliders"]);
  //         return NewReleasesModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return NewReleasesModal(error: "401");
  //   }
  // }
  //
  // static Future<WeeklyProductsModal?> WeeklyProductsApi(pageNum,sortVal,price,brand,stck,dis) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       // String sortCondition = sort_value ?? ""; // Use default value if null
  //       // List<String> filterCondition = price_filters;
  //       Map<String, dynamic> data = {
  //         'page_count': pageNum.toString(),
  //         'sort_condition':sortVal,
  //         'price_filter':jsonEncode(price).toString(),
  //         'stock_filter':stck,
  //         'discount_filter':dis,
  //         'brand_filter':jsonEncode(brand).toString()
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, WeeklyProductsApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         //  print(jsonDecode(res.body)["bottom_sliders"]);
  //         return WeeklyProductsModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return WeeklyProductsModal(error: "401");
  //   }
  // }
  //
  // static Future<CategoriesListModal?> CategoriesListApi() async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       final header = await HeaderValues();
  //       final res = await post({}, CategoriesListApiName, header);
  //       if (res != null) {
  //         return CategoriesListModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return CategoriesListModal(error: "401", message: "Logout", list: []);
  //   }
  // }
  //
  // static Future<ProfileDetailsModel?> ProfileDetailsApi() async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       final header = await HeaderValues();
  //       final res = await post({}, ProfileDetailsApiName, header);
  //       if (res != null) {
  //         // print(res.body);
  //         return ProfileDetailsModel.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return ProfileDetailsModel(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<CartListModel?> CartListApi() async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       final header = await HeaderValues();
  //       final res = await post({}, CartListApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         return CartListModel.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return CartListModel(error: "401");
  //   }
  // }
  //
  // static Future<OrderListModel?> OrdersListApi(sortValue) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, dynamic> data = {
  //         'data_range': sortValue.toString(),
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, OrdersListApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         return OrderListModel.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return OrderListModel(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<OrderDetailsModel?> OrderDetailsApi(id) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {'order_id': id.toString()};
  //       final header = await HeaderValues();
  //       final res = await post(data, OrderDetailsApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         return OrderDetailsModel.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return OrderDetailsModel(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<CategoriesListModal?> SubCategoriesListApi(id) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {'main_category_id': id.toString()};
  //       final header = await HeaderValues();
  //       final res = await post(data, SubCategoriesListApiName, header);
  //       if (res != null) {
  //         // print(res.body);
  //         return CategoriesListModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return CategoriesListModal(error: "401", message: "Logout", list: []);
  //   }
  // }
  //
  // static Future<OperationalResponseModal?> EditProfileDetailsApi(
  //     name, emailId, dob, countyId, image) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'name': name.toString(),
  //         'email_id': emailId.toString(),
  //         'date_of_birth': dob.toString(),
  //         'mobile_number_country_id': countyId.toString(),
  //       };
  //       final header = await HeaderValues();
  //
  //       var res;
  //       if (image != null) {
  //         // print("object");
  //         res = await postImage(data, EditProfileDetailsApiName, header, image);
  //         res = jsonDecode(res);
  //       } else {
  //         // print("object2");
  //
  //         res = await post(data, EditProfileDetailsApiName, header);
  //         res = jsonDecode(res.body);
  //       }
  //       if (res != null) {
  //         return OperationalResponseModal.fromJson(res);
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return OperationalResponseModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<ApplyCouponModel?> ApplyCouponApi(id) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {'coupon_id': id.toString()};
  //       final header = await HeaderValues();
  //       final res = await post(data, ApplyCouponApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         return ApplyCouponModel.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return ApplyCouponModel(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<ApplyCouponModel?> RemoveCouponApi() async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {'coupon_id': "0"};
  //       final header = await HeaderValues();
  //       final res = await post(data, RemoveCouponApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         return ApplyCouponModel.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return ApplyCouponModel(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<OperationalResponseModal?> RepeateOrderApi(id) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {'order_id': id.toString()};
  //       // print(data);
  //       final header = await HeaderValues();
  //       final res = await post(data, RepeateOrderApiName, header);
  //       if (res != null) {
  //         // print(res.body);
  //         return OperationalResponseModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return OperationalResponseModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<AddOrderModal?> AddOrderApi(
  //     couponCode, total, itemsTotal, paymentType, orderSource,freeItems) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       var f = NumberFormat("###.0#", "en_US");
  //       Map<String, String> data = {
  //         'coupon_code': couponCode.toString(),
  //         'total_amount': total.toString(),
  //         'items_total': (itemsTotal.toString()),
  //         'payment_type': (paymentType.toString()),
  //         'rewards_used': "0",
  //         'order_placed_from': 'mobile',
  //         'order_source': orderSource.toString(),
  //         'free_items':jsonEncode(freeItems).toString()
  //       };
  //       print(data);
  //       final header = await HeaderValues();
  //       final res = await post(data, AddOrderApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         return AddOrderModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return AddOrderModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<CollectionProductsModel?> CollectionProductsListApi(id,page,sortVal,price,brand,stck,dis) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'product_collection_id': id.toString(),
  //         'page_count':page.toString(),
  //         'sort_condition':sortVal,
  //         'price_filter':jsonEncode(price).toString(),
  //         'stock_filter':stck,
  //         'discount_filter':dis,
  //         'brand_filter':jsonEncode(brand).toString()
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, CollectionProductsListApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         print(jsonDecode(res.body)["product_collection_id"]);
  //         return CollectionProductsModel.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return CollectionProductsModel(error: "401", message: "Logout");
  //   }
  // }
  //
  // //BrandProductsAPI
  // static Future<BrandProductsModel?> BrandProductsListApi(id, pageNum) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'brand_id': id.toString(),
  //         'category_id': "0",
  //         'page_num': pageNum.toString()
  //       };
  //       final header = await HeaderValues();
  //       final res =
  //           await post(data, BrandProductsCollectionListApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         print(jsonDecode(res.body)["brand_id"]);
  //         return BrandProductsModel.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return BrandProductsModel(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<ProductListModal?> ProductsListApi(id, page) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'category_id': id.toString(),
  //         'page_number': page.toString()
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, ProductsListApiName, header);
  //       if (res != null) {
  //         // print(res.body);
  //         return ProductListModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return ProductListModal(error: "401", message: "Logout", productList: []);
  //   }
  // }
  //
  // static Future<ProductListModal?> FavouriteListApi() async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       final header = await HeaderValues();
  //       final res = await post({}, FavouriteListApiName, header);
  //       if (res != null) {
  //         return ProductListModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return ProductListModal(error: "401", message: "Logout", productList: []);
  //   }
  // }
  //
  // static Future<AddressListModal?> AddressListApi() async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       final header = await HeaderValues();
  //       final res = await post({}, AddressListApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         return AddressListModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return AddressListModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<CouponsListModal?> CouponListApi(String orderAmount) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {'order_amount': orderAmount.toString()};
  //       final header = await HeaderValues();
  //       final res = await post(data, CouponsListApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         return CouponsListModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return CouponsListModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<ContactsListModel?> ContactsListApi() async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       final header = await HeaderValues();
  //       final res = await post({}, ContactsListApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         return ContactsListModel.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return ContactsListModel(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<ProductDetailsModal?> ProductDetailsApi(id) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {'product_id': id.toString()};
  //       final header = await HeaderValues();
  //       final res = await post(data, ProductDetailsApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         return ProductDetailsModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return ProductDetailsModal(
  //         error: "401", message: "Logout", details: null);
  //   }
  // }
  //
  // static Future<OperationalResponseModal?> AddAddressApi(
  //     loc, locAdd, addType, flatNo, extra, pincode, landmark, other) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'loc': loc.toString(),
  //         'loc_address': locAdd.toString(),
  //         'address_type': addType.toString(),
  //         'address_line_1': flatNo.toString(),
  //         'address_line_2': extra.toString(),
  //         'pincode': pincode.toString(),
  //         'landmark': landmark.toString(),
  //         'other_address_type': other.toString(),
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, AddAddressApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         return OperationalResponseModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return OperationalResponseModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<OperationalResponseModal?> EditAddressApi(id, loc, locAdd,
  //     addType, flatNo, extra, pincode, landmark, other) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'address_id': id.toString(),
  //         'loc': loc.toString(),
  //         'loc_address': locAdd.toString(),
  //         'address_type': addType.toString(),
  //         'address_line1': flatNo.toString(),
  //         'address_line2': extra.toString(),
  //         'pincode': pincode.toString(),
  //         'landmark': landmark.toString(),
  //         'other_address_type': other.toString(),
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, EditAddressApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         return OperationalResponseModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return OperationalResponseModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<AddressDetailsModel?> AddressDetailsApi(id) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'address_id': id.toString(),
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, AddressDetailsApiName, header);
  //       if (res != null) {
  //         return AddressDetailsModel.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return AddressDetailsModel(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<OperationalResponseModal?> ClearCartApi() async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       final header = await HeaderValues();
  //       final res = await post({}, ClearCartApiName, header);
  //       if (res != null) {
  //         return OperationalResponseModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return OperationalResponseModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<OperationalResponseModal?> DeleteCartItemApi(id) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'cart_id': id.toString(),
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, DeleteCartItemApiName, header);
  //       if (res != null) {
  //         return OperationalResponseModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return OperationalResponseModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<OperationalResponseModal?> DeleteAddressApi(id) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'address_id': id.toString(),
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, DeleteAddressApiName, header);
  //       if (res != null) {
  //         return OperationalResponseModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return OperationalResponseModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<OperationalResponseModal?> DeleteContactApi(id) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'contact_id': id.toString(),
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, DeleteContactApiName, header);
  //       if (res != null) {
  //         return OperationalResponseModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return OperationalResponseModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<OperationalResponseModal?> UpdateContactSelectionApi(id) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'contact_id': id.toString(),
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, UpdateContactSelectionApiName, header);
  //       if (res != null) {
  //         return OperationalResponseModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return OperationalResponseModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<OperationalResponseModal?> UpdateAddressSelectionApi(id) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'address_id': id.toString(),
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, UpdateAddressSelectionApiName, header);
  //       if (res != null) {
  //         return OperationalResponseModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return OperationalResponseModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<OperationalResponseModal?> AddContactApi(
  //     name, countryId, mobile) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'name': name.toString(),
  //         'mobile_number_country_id': countryId.toString(),
  //         'mobile_number': mobile.toString()
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, AddContactApiName, header);
  //       if (res != null) {
  //         return OperationalResponseModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return OperationalResponseModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<OperationalResponseModal?> UpdateFavoriteApi(id) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {'product_id': id.toString()};
  //       final header = await HeaderValues();
  //       final res = await post(data, UpdateFavoriteApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         return OperationalResponseModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return OperationalResponseModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<UniversalSearchModal?> UniversalSearchApi(searchText) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'search_string': searchText.toString(),
  //         // 'page_num': page_num.toString()
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, UniversalSearchApiName, header);
  //       if (res != null) {
  //          print(res.body);
  //         return UniversalSearchModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return UniversalSearchModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<UniversalProductSearchModal?> UniversalProductSearchApi(
  //     searchText, pageNum) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'search_string': searchText.toString(),
  //         'page_num': pageNum.toString()
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, UniversalProductSearchApiName, header);
  //       if (res != null) {
  //         return UniversalProductSearchModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return UniversalProductSearchModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<AddToCartModel?> AddToCartApi(id, quantity) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'product_id': id.toString(),
  //         'quantity': quantity.toString()
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, AddToCartApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         return AddToCartModel.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return AddToCartModel(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<StoreLocaterModal?> Storelocatorapi(location) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {'location': location.toString()};
  //       final header = await HeaderValues();
  //       final res = await post(data, StorelocatorApi, header);
  //       if (res != null) {
  //         print(res.body);
  //         return StoreLocaterModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return StoreLocaterModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<ReviewsListModal?> ReviewsListApi(id) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {'item_id': id.toString()};
  //       final header = await HeaderValues();
  //       final res = await post(data, ReviewsListApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         return ReviewsListModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return ReviewsListModal(error: "401");
  //   }
  // }
  //
  // static Future<AverageRatingsModal?> AverageRatingListApi(id) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {'item_id': id.toString()};
  //       final header = await HeaderValues();
  //       final res = await post(data, AverageratingListApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         return AverageRatingsModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return AverageRatingsModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<UpdateRatingsModel?> UpdateCustomRatingListApi(
  //     id, rating, review) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'item_id': id.toString(),
  //         'rating': rating.toString(),
  //         'review': review.toString()
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, UpdateCustomRatingListApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         return UpdateRatingsModel.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return UpdateRatingsModel(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<phonepemodel?> PhonePeCredListApi() async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       final header = await HeaderValues();
  //       final res = await post({}, phonepeCredsApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         return phonepemodel.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return phonepemodel(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<Razorpaymodel?> RazorpayApi(amount, refData) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'amount': amount.toString(),
  //         'ref_data': jsonEncode(refData),
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, insert_razorpay_orderApi, header);
  //       if (res != null) {
  //         print(res.body);
  //         return Razorpaymodel.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return Razorpaymodel(error: 401, message: "Logout");
  //   }
  // }
  //
  // static Future<paymentAvailablemodal?> PaymentsAvailableApiCalling() async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       final header = await HeaderValues();
  //       final res = await post({}, paymentAvailableApi, header);
  //       if (res != null) {
  //         return paymentAvailablemodal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return paymentAvailablemodal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<FitPointsModal?> FitPointsApi() async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       final header = await HeaderValues();
  //       final res = await post({}, FitPointsApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         return FitPointsModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return FitPointsModal(error: "401");
  //   }
  // }
  //
  // static Future<NotifyMeModal?> NotifyMeApi(id, [var itemName = ""]) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'item_id': id.toString(),
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, NotifyMeApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         return NotifyMeModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return NotifyMeModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<AddItemRequestModal?> AddItemRequest(itemName,itemImage) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'item_name': itemName.toString(),
  //         'item_image': " "
  //       };
  //       final header = await HeaderValues();
  //       var res;
  //
  //       if(itemImage!=null){
  //          res = await postImage2(data, AddItemRequestApiName, header,itemImage);
  //          res = jsonDecode(res);
  //          print(res.body);
  //       }else{
  //         res = await post(data, AddItemRequestApiName, header);
  //         res = jsonDecode(res.body);
  //         print(res.body);
  //       }
  //
  //       if (res != null) {
  //         print(res.body);
  //         return AddItemRequestModal.fromJson(jsonDecode(res));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return AddItemRequestModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<BuyNowModal?> BuyNowAPI(
  //     product_id) async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       Map<String, String> data = {
  //         'product_id': product_id.toString(),
  //       };
  //       final header = await HeaderValues();
  //       final res = await post(data, BuyNowApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         return BuyNowModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return BuyNowModal(error: "401", message: "Logout");
  //   }
  // }
  //
  // static Future<DeletionModal?> DeletionAPI() async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       final header = await HeaderValues();
  //       final res = await post({}, deleteApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         //  print(jsonDecode(res.body)["bottom_sliders"]);
  //         return DeletionModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return DeletionModal(error: "401");
  //   }
  // }
  //
  // static Future<ConfirmDeletionModal?> ConfirmDeletionAPI() async {
  //   if (await CheckHeaderValidity()) {
  //     try {
  //       final header = await HeaderValues();
  //       final res = await post({}, confirmDeleteApiName, header);
  //       if (res != null) {
  //         print(res.body);
  //         //  print(jsonDecode(res.body)["bottom_sliders"]);
  //         return ConfirmDeletionModal.fromJson(jsonDecode(res.body));
  //       } else {
  //         print("Null Response");
  //         return null;
  //       }
  //     } catch (e) {
  //       debugPrint('hello bev=bug $e ');
  //       return null;
  //     }
  //   } else {
  //     return ConfirmDeletionModal(error: "401");
  //   }
  // }


}
