import 'dart:convert';
import 'package:demoproject/Utils/constants.dart';
import 'package:demoproject/Utils/urlUtils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/org.model.dart';

import '../Utils/sharedPrefs.dart';

class OrganizationProvider with ChangeNotifier {
  List<OrganizationModel> _organizations = [];

  List<OrganizationModel> get organizations => _organizations;

  Future<void> fetchOrganizations() async {
    try {
      // final token = SharedPrefs.pref.getString('github_token'); // Retrieve token
      var userName =
          jsonDecode(SharedPrefs.pref.getString('profile') ?? "")['login'];
      var url = ORGLIST + '/${userName}' + '/orgs';
      final response = await http.get(Uri.parse(url));
      show_log_error("ORGLIST is ${url}");
      show_log_error("ORGLIST is response ${response.body}");

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        _organizations =
            data.map((org) => OrganizationModel.fromJson(org)).toList();
        notifyListeners();
      } else {
        _organizations = [];  
        throw Exception('Failed to load organizations');
      }
    } catch (e) {
      _organizations = [];
      print('Error fetching organizations: $e');
    }
  }
}
