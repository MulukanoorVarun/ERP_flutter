import 'dart:ui';

import 'package:flutter/material.dart';

class AttendanceHistory {
  int? presentDays;
  int? absentDays;
  int? holidays;
  int? latePenalties;
  DateArray? dateArray;
  LatePenaltyArray? latePenaltyArray;
  int? error;
  int? sessionExists;

  AttendanceHistory(
      {this.presentDays,
        this.absentDays,
        this.holidays,
        this.latePenalties,
        this.dateArray,
        this.latePenaltyArray,
        this.error,
        this.sessionExists});

  AttendanceHistory.fromJson(Map<String, dynamic> json) {
    presentDays = json['present_days'];
    absentDays = json['absent_days'];
    holidays = json['holidays'];
    latePenalties = json['late_penalties'];
    dateArray = json['date_array'] != null
        ? new DateArray.fromJson(json['date_array'])
        : null;
    latePenaltyArray = json['late_penalty_array'] != null
        ? new LatePenaltyArray.fromJson(json['late_penalty_array'])
        : null;
    error = json['error'];
    sessionExists = json['session_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['present_days'] = this.presentDays;
    data['absent_days'] = this.absentDays;
    data['holidays'] = this.holidays;
    data['late_penalties'] = this.latePenalties;
    if (this.dateArray != null) {
      data['date_array'] = this.dateArray!.toJson();
    }
    if (this.latePenaltyArray != null) {
      data['late_penalty_array'] = this.latePenaltyArray!.toJson();
    }
    data['error'] = this.error;
    data['session_exists'] = this.sessionExists;
    return data;
  }
}

class DateArray {
  String? s20240126;
  String? s20240127;
  String? s20240128;
  String? s20240129;
  String? s20240130;
  String? s20240131;
  String? s20240201;
  String? s20240202;
  String? s20240203;
  String? s20240204;
  String? s20240205;
  String? s20240206;
  String? s20240207;
  String? s20240208;
  String? s20240209;
  String? s20240210;
  String? s20240211;
  String? s20240212;
  String? s20240213;
  String? s20240214;
  String? s20240215;
  String? s20240216;
  String? s20240217;
  String? s20240218;
  String? s20240219;
  String? s20240220;
  String? s20240221;
  String? s20240222;
  String? s20240223;
  String? s20240224;
  String? s20240225;

  DateArray(
      {this.s20240126,
        this.s20240127,
        this.s20240128,
        this.s20240129,
        this.s20240130,
        this.s20240131,
        this.s20240201,
        this.s20240202,
        this.s20240203,
        this.s20240204,
        this.s20240205,
        this.s20240206,
        this.s20240207,
        this.s20240208,
        this.s20240209,
        this.s20240210,
        this.s20240211,
        this.s20240212,
        this.s20240213,
        this.s20240214,
        this.s20240215,
        this.s20240216,
        this.s20240217,
        this.s20240218,
        this.s20240219,
        this.s20240220,
        this.s20240221,
        this.s20240222,
        this.s20240223,
        this.s20240224,
        this.s20240225});

  DateArray.fromJson(Map<String, dynamic> json) {
    s20240126 = json['2024-01-26'];
    s20240127 = json['2024-01-27'];
    s20240128 = json['2024-01-28'];
    s20240129 = json['2024-01-29'];
    s20240130 = json['2024-01-30'];
    s20240131 = json['2024-01-31'];
    s20240201 = json['2024-02-01'];
    s20240202 = json['2024-02-02'];
    s20240203 = json['2024-02-03'];
    s20240204 = json['2024-02-04'];
    s20240205 = json['2024-02-05'];
    s20240206 = json['2024-02-06'];
    s20240207 = json['2024-02-07'];
    s20240208 = json['2024-02-08'];
    s20240209 = json['2024-02-09'];
    s20240210 = json['2024-02-10'];
    s20240211 = json['2024-02-11'];
    s20240212 = json['2024-02-12'];
    s20240213 = json['2024-02-13'];
    s20240214 = json['2024-02-14'];
    s20240215 = json['2024-02-15'];
    s20240216 = json['2024-02-16'];
    s20240217 = json['2024-02-17'];
    s20240218 = json['2024-02-18'];
    s20240219 = json['2024-02-19'];
    s20240220 = json['2024-02-20'];
    s20240221 = json['2024-02-21'];
    s20240222 = json['2024-02-22'];
    s20240223 = json['2024-02-23'];
    s20240224 = json['2024-02-24'];
    s20240225 = json['2024-02-25'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['2024-01-26'] = this.s20240126;
    data['2024-01-27'] = this.s20240127;
    data['2024-01-28'] = this.s20240128;
    data['2024-01-29'] = this.s20240129;
    data['2024-01-30'] = this.s20240130;
    data['2024-01-31'] = this.s20240131;
    data['2024-02-01'] = this.s20240201;
    data['2024-02-02'] = this.s20240202;
    data['2024-02-03'] = this.s20240203;
    data['2024-02-04'] = this.s20240204;
    data['2024-02-05'] = this.s20240205;
    data['2024-02-06'] = this.s20240206;
    data['2024-02-07'] = this.s20240207;
    data['2024-02-08'] = this.s20240208;
    data['2024-02-09'] = this.s20240209;
    data['2024-02-10'] = this.s20240210;
    data['2024-02-11'] = this.s20240211;
    data['2024-02-12'] = this.s20240212;
    data['2024-02-13'] = this.s20240213;
    data['2024-02-14'] = this.s20240214;
    data['2024-02-15'] = this.s20240215;
    data['2024-02-16'] = this.s20240216;
    data['2024-02-17'] = this.s20240217;
    data['2024-02-18'] = this.s20240218;
    data['2024-02-19'] = this.s20240219;
    data['2024-02-20'] = this.s20240220;
    data['2024-02-21'] = this.s20240221;
    data['2024-02-22'] = this.s20240222;
    data['2024-02-23'] = this.s20240223;
    data['2024-02-24'] = this.s20240224;
    data['2024-02-25'] = this.s20240225;
    return data;
  }
}

class LatePenaltyArray {
  int? i20240126;
  int? i20240127;
  int? i20240128;
  int? i20240129;
  int? i20240130;
  int? i20240131;
  int? i20240201;
  int? i20240202;
  int? i20240203;
  int? i20240204;
  int? i20240205;
  int? i20240206;
  int? i20240207;
  int? i20240208;
  int? i20240209;
  int? i20240210;
  int? i20240211;
  int? i20240212;
  int? i20240213;
  int? i20240214;
  int? i20240215;
  int? i20240216;
  int? i20240217;
  int? i20240218;
  int? i20240219;
  int? i20240220;
  int? i20240221;
  int? i20240222;
  int? i20240223;
  int? i20240224;
  int? i20240225;

  LatePenaltyArray(
      {this.i20240126,
        this.i20240127,
        this.i20240128,
        this.i20240129,
        this.i20240130,
        this.i20240131,
        this.i20240201,
        this.i20240202,
        this.i20240203,
        this.i20240204,
        this.i20240205,
        this.i20240206,
        this.i20240207,
        this.i20240208,
        this.i20240209,
        this.i20240210,
        this.i20240211,
        this.i20240212,
        this.i20240213,
        this.i20240214,
        this.i20240215,
        this.i20240216,
        this.i20240217,
        this.i20240218,
        this.i20240219,
        this.i20240220,
        this.i20240221,
        this.i20240222,
        this.i20240223,
        this.i20240224,
        this.i20240225});

  LatePenaltyArray.fromJson(Map<String, dynamic> json) {
    i20240126 = json['2024-01-26'];
    i20240127 = json['2024-01-27'];
    i20240128 = json['2024-01-28'];
    i20240129 = json['2024-01-29'];
    i20240130 = json['2024-01-30'];
    i20240131 = json['2024-01-31'];
    i20240201 = json['2024-02-01'];
    i20240202 = json['2024-02-02'];
    i20240203 = json['2024-02-03'];
    i20240204 = json['2024-02-04'];
    i20240205 = json['2024-02-05'];
    i20240206 = json['2024-02-06'];
    i20240207 = json['2024-02-07'];
    i20240208 = json['2024-02-08'];
    i20240209 = json['2024-02-09'];
    i20240210 = json['2024-02-10'];
    i20240211 = json['2024-02-11'];
    i20240212 = json['2024-02-12'];
    i20240213 = json['2024-02-13'];
    i20240214 = json['2024-02-14'];
    i20240215 = json['2024-02-15'];
    i20240216 = json['2024-02-16'];
    i20240217 = json['2024-02-17'];
    i20240218 = json['2024-02-18'];
    i20240219 = json['2024-02-19'];
    i20240220 = json['2024-02-20'];
    i20240221 = json['2024-02-21'];
    i20240222 = json['2024-02-22'];
    i20240223 = json['2024-02-23'];
    i20240224 = json['2024-02-24'];
    i20240225 = json['2024-02-25'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['2024-01-26'] = this.i20240126;
    data['2024-01-27'] = this.i20240127;
    data['2024-01-28'] = this.i20240128;
    data['2024-01-29'] = this.i20240129;
    data['2024-01-30'] = this.i20240130;
    data['2024-01-31'] = this.i20240131;
    data['2024-02-01'] = this.i20240201;
    data['2024-02-02'] = this.i20240202;
    data['2024-02-03'] = this.i20240203;
    data['2024-02-04'] = this.i20240204;
    data['2024-02-05'] = this.i20240205;
    data['2024-02-06'] = this.i20240206;
    data['2024-02-07'] = this.i20240207;
    data['2024-02-08'] = this.i20240208;
    data['2024-02-09'] = this.i20240209;
    data['2024-02-10'] = this.i20240210;
    data['2024-02-11'] = this.i20240211;
    data['2024-02-12'] = this.i20240212;
    data['2024-02-13'] = this.i20240213;
    data['2024-02-14'] = this.i20240214;
    data['2024-02-15'] = this.i20240215;
    data['2024-02-16'] = this.i20240216;
    data['2024-02-17'] = this.i20240217;
    data['2024-02-18'] = this.i20240218;
    data['2024-02-19'] = this.i20240219;
    data['2024-02-20'] = this.i20240220;
    data['2024-02-21'] = this.i20240221;
    data['2024-02-22'] = this.i20240222;
    data['2024-02-23'] = this.i20240223;
    data['2024-02-24'] = this.i20240224;
    data['2024-02-25'] = this.i20240225;
    return data;
  }

}