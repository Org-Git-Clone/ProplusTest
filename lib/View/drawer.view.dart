import 'dart:convert';

import 'package:demoproject/Controller/repo.controller.dart';
import 'package:demoproject/Utils/sharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../Controller/org.controller.dart';
import '../Utils/navigation.dart';

class NavigationDrawerView extends StatefulWidget {
  @override
  State<NavigationDrawerView> createState() => _NavigationDrawerViewState();
}

class _NavigationDrawerViewState extends State<NavigationDrawerView> {
  @override
  void initState() {
    super.initState();
    // Fetch organizations only once during initialization
    Provider.of<OrganizationProvider>(context, listen: false)
        .fetchOrganizations();
  }

  @override
  Widget build(BuildContext context) {
    var profileInfo = jsonDecode(SharedPrefs.pref.getString('profile') ?? "");
    final organizationProvider = Provider.of<OrganizationProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        children: [
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
              child: Row(children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFFD3DDFF)),
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  child: Image.network('${profileInfo!["avatar_url"]}'),
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profileInfo!["name"],
                      style: TextStyle(
                          color: Color(0xFF27274A),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: ShapeDecoration(
                              color: Color(0xFFFF9C37),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${profileInfo!["login"]}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ])),
          Consumer<OrganizationProvider>(
            builder: (context, provider, child) {
              if (provider.organizations.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.organizations.length,
                  itemBuilder: (context, index) {
                    final org = provider.organizations[index];
                    return GestureDetector(
                      onTap: () {
                        Provider.of<RepositoryProvider>(context, listen: false)
                            .fetchRepoForOrg(org);
                        router.pop();

                        // router.go('/dashboard');
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Container(
                                  width: 40,
                                  height: 40,
                                  padding: const EdgeInsets.all(10),
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1, color: Color(0xFFEDECFF)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Image.network(org.avatarUrl)),
                              SizedBox(width: 5),
                              Text(
                                '${org.login}',
                                style: TextStyle(
                                    color: Color(0xFF27274A),
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFFEDECFF)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Image.asset('assets/images/logout.png')),
                  SizedBox(width: 5),
                  Text(
                    'logout',
                    style: TextStyle(
                        color: Color(0xFF27274A),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
