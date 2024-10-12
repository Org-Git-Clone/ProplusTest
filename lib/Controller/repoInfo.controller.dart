import 'dart:convert';
import 'package:demoproject/Model/repo.model.dart';
import 'package:demoproject/Utils/constants.dart';
import 'package:demoproject/Utils/urlUtils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/org.model.dart';

import '../Utils/sharedPrefs.dart';

class RepoInfoProvider with ChangeNotifier {
  OrganizationModel? _selectedOrganization;
  Repository? _repoInfo;

  OrganizationModel? get selectedOrganization => _selectedOrganization;
  Repository? get repoInfo => _repoInfo;

  Future<void> fetchRepoForOrg(OrganizationModel org, Repository repoInfos) async {
    try {
      final response = await http.get(
        Uri.parse('${repoInfos.url}/branches'),
      );
      show_log_error("ORGLIST is ${org.reposUrl}");
      show_log_error("ORGLIST is response ${response.body}");

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        _selectedOrganization = org;
        
        notifyListeners();
      } else {
        throw Exception('Failed to load organizations');
      }
    } catch (e) {
      print('Error fetching organizations: $e');
    }
  }
}
