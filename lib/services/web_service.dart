import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swdprojectbackup/models/account.dart';
import 'package:swdprojectbackup/models/application.dart';
import 'package:swdprojectbackup/models/companyChoose.dart';
import 'package:swdprojectbackup/models/news.dart';
import 'package:swdprojectbackup/models/profile.dart';
import 'package:swdprojectbackup/utils/constants.dart';
import 'package:http/http.dart' as http;




class WebService {
  var dio = new Dio();

  Future<bool> loginByEmail(String email) async {
    String url = Constants.LOGIN_BY_EMAIL + '/$email';
    print(url);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getIdToken(String token) async {
    String url = Constants.GET_ID_TOKEN;
    print(url+token);
    final response = await dio.post(url + token);
    if (response.statusCode == 200) {
      print('status code 200');
      Map<String, dynamic> result = response.data;
      print('${result["token"]}');
      return result["token"];
    } else {
      throw Exception("Failled to get news");
    }
  }

  Future<List<News>> fetchTopHeadlines(int pageNum, String uniCode, String majorCode, String subject) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idToken = await prefs.getString('idToken');
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${idToken}";
    String url = Constants.TOP_HEADLINES_URL + '/$pageNum' + '/$uniCode' + '/$majorCode' + '/$subject';
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      Iterable result = response.data;
      Iterable list = result;
      return list.map((article) => News.fromJson(article)).toList();
    } else {
      throw Exception("Failled to get news");
    }
  }

  Future<News> getNewsDetailById(int idNews) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idToken = await prefs.getString('idToken');
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${idToken}";
    String url = Constants.GET_NEWS_DETAIL_BY_ID + '/$idNews';
    print(url);
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> result = response.data;
      News news = News.fromJson(result);
      return news;
    } else {
      throw Exception("Failled to get news");
    }
  }

  Future<Profile> getProfile(String email,String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idToken = await prefs.getString('idToken');
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${idToken}";
    print('service profile running');
    print('$email');
    String url = Constants.GET_PROFILE_BY_EMAIL_ROLE + '/$email';
    print('$url');
    // RequestOptions options;
    // options.headers["Authorization"] = "Bearer " + token;
    var response = await dio.get(url);
    print(response.toString());
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> result = response.data;
      print('aaaaaaaaaaaaa $result');
      return Profile.fromJson(result);
    } else {
      throw Exception("Failled to get profile");
    }
  }

  Future<bool> updateProfile(Profile profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idToken = await prefs.getString('idToken');
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${idToken}";
    print('update profile processing');
    String url = Constants.UPDATE_PROFILE + '/${profile.code}';
    print('$url');
    print(json.encode(profile.toJson()) );
    var param = {
      "_id": profile.code
    };
    var response = await dio.put(url, queryParameters: param, data: json.encode(profile.toJson()) );
    print(response.toString());
    if (response.statusCode == 204) {
      print('aaaaaaaaaaaa');
      return true;
    } else {
      return false;
    }
  }

  Future<List<CompanyChoose>> getCompanyChoose(String uniCode, String majorCode, String subject) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idToken = await prefs.getString('idToken');
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${idToken}";
    print('get company choose');
    String url = Constants.GET_COMPANY_CHOOSE + '/$uniCode/$majorCode/$subject';
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      Iterable result = response.data;
      return result.map((com) => CompanyChoose.fromJson(com)).toList();
    } else {
      throw Exception("Failled to get profile");
    }
  }

  Future<bool> applyJob(Application application,String token) async {
    print('post application processing -stuCode:${application.stuCode} - appId:${application.jobId}');
    String url = Constants.APPLY_JOB;
    // print('token - $token');
    var data = {
      "stuCode": "${application.stuCode}",
      "jobId": json.encode(application.jobId),
      "status": "${application.status}",
    };
    // RequestOptions options;
    // options.headers["Authorization"] = "Bearer " + token;
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${token}";
    // print(json.encode(application.toJson()));
    var response = await dio.post(url, data: data);
    // var response = await dio.post(url, data: testData);
    print(response.toString());
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateLastSent(String stuCode, int lastSent) async {
    print('update last send -stuCode:${stuCode} - lastSent:${lastSent}');
    String url = Constants.UPDATE_PROFILE + '/$stuCode' + '/$lastSent';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idToken = await prefs.getString('idToken');
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${idToken}";
    // print(json.encode(application.toJson()));
    var response = await dio.put(url);
    // var response = await dio.post(url, data: testData);
    print(response.toString());
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

}