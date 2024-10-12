import 'dart:convert';
import 'package:demoproject/Model/repo.model.dart';
import 'package:demoproject/Utils/constants.dart';
import 'package:demoproject/Utils/urlUtils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/org.model.dart';

import '../Utils/sharedPrefs.dart';

class RepositoryProvider with ChangeNotifier {
  List<Repository> _repoInfos = [];

  List<Repository> get repoInfos => _repoInfos;

  OrganizationModel? _selectedOrganization;
  OrganizationModel? get selectedOrganization => _selectedOrganization;

  Future<void> fetchRepoForOrg(OrganizationModel org) async {
    try {
      final response = await http.get(
        Uri.parse(org.reposUrl),
        headers: {
          'Authorization': 'Bearer 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'
        },
      );
      show_log_error("ORGLIST is ${org.reposUrl}");
      show_log_error("ORGLIST is response ${response.body}");

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        _selectedOrganization = org;
        _repoInfos = data.map((repo) => Repository.fromJson(repo)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load organizations');
      }
    } catch (e) {
      print('Error fetching organizations: $e');
    }
  }
}
