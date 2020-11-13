import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:swdprojectbackup/models/account.dart';
import 'package:swdprojectbackup/models/companyChoose.dart';
import 'package:swdprojectbackup/models/news.dart';
import 'package:swdprojectbackup/models/profile.dart';
import 'package:swdprojectbackup/utils/constants.dart';




class WebService {
  var dio = new Dio();

  Future<List<News>> fetchTopHeadlines(int pageNum, String uniCode, String majorCode, String subject) async {
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

  Future<Profile> getProfile(String email, String role) async {
    print('service profile running');
    String url = Constants.GET_PROFILE_BY_EMAIL_ROLE + '/$email/$role';
    print('$url');
    var response = await dio.get(url);
    print(response.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> result = response.data;
      print('aaaaaaaaaaaaa $result');
      return Profile.fromJson(result);
    } else {
      throw Exception("Failled to get profile");
    }
  }

  Future<bool> updateProfile(Profile profile) async {
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
      throw Exception("Failled to get profile");
    }
    return false;
  }

  Future<List<CompanyChoose>> getCompanyChoose(String uniCode, String majorCode, String subject) async {
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

}