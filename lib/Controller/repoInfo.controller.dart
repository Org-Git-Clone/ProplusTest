import 'dart:convert';
import 'package:demoproject/Model/repo.model.dart';
import 'package:demoproject/Model/repoInfo.model.dart';
import 'package:demoproject/Utils/constants.dart';
import 'package:demoproject/Utils/urlUtils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/commit.model.dart';
import '../Model/org.model.dart';

import '../Utils/sharedPrefs.dart';

class RepoInfoProvider with ChangeNotifier {
  OrganizationModel? _selectedOrganization;
  Repository? _repoInfo;

  OrganizationModel? get selectedOrganization => _selectedOrganization;

  Repository? get repoInfo => _repoInfo;
  List<Branch> branchList = [];
  List<CommitInfo> _commitInfo = [];
  List<CommitInfo> get commitInfo => _commitInfo;

  Future<void> fetchRepoForOrg(OrganizationModel org, Repository repoInfos,
      {var getFirst = true}) async {
    branchList = [];
    _commitInfo = [];
    try {
      final response = await http.get(
        Uri.parse('${repoInfos.url}/branches'),
      );
      show_log_error("ORGLIST is ${org.reposUrl}");
      show_log_error("ORGLIST is response ${response.body}");

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        _selectedOrganization = org;

        var branchInfo = data.map((value) => Branch.fromJson(value)).toList();
        show_log_error("branchInfo is ${branchInfo.length}");
        branchList = branchInfo;

        notifyListeners();
        if (getFirst == true) {
          if (branchInfo.length > 0) {
            await getFirstBranchesCommit(branchInfo.first, org, repoInfos);
          }
        }
      } else {
        throw Exception('Failed to load organizations');
      }
    } catch (e) {
      print('Error fetching organizations: $e');
    }
  }

  getFirstBranchesCommit(
      Branch first, OrganizationModel org, Repository repoInfos) async {
    commitInfo.clear();
    notifyListeners();
    try {
      final response = await http.get(
        Uri.parse('${repoInfos.url}/commits'),
      );
      show_log_error("repoInfos is ${org.reposUrl}");
      show_log_error("repoInfos is response ${response.body}");

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        _selectedOrganization = org;

        var commitInfos =
            data.map((value) => CommitInfo.fromJson(value)).toList();
        show_log_error("branchInfo is ${commitInfos.length}");
        _commitInfo = commitInfos;
        notifyListeners();
      } else {
        throw Exception('Failed to load organizations');
      }
    } catch (e) {
      print('Error fetching organizations: $e');
    }
  }
}
