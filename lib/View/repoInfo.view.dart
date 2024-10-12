import 'package:demoproject/Controller/repoInfo.controller.dart';
import 'package:demoproject/Utils/constants.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../Controller/repo.controller.dart';
import '../Model/org.model.dart';
import '../Model/repo.model.dart';
import '../Utils/sharedPrefs.dart';
import 'drawer.view.dart';

class RepoInfoView extends StatefulWidget {
  Repository repoInfo;
  OrganizationModel? selectedOrganization;
  RepoInfoView(
      {super.key, required this.repoInfo, required this.selectedOrganization});

  @override
  State<RepoInfoView> createState() => _RepoInfoViewState();
}

class _RepoInfoViewState extends State<RepoInfoView> {
  var tapIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<RepoInfoProvider>(context, listen: false)
        .fetchRepoForOrg(widget.selectedOrganization!, widget.repoInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: wAppBarView(),
        drawer: NavigationDrawerView(),
        body: Consumer<RepoInfoProvider>(builder: (context, provider, child) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                wRepoInfo(widget.repoInfo, widget.selectedOrganization),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: wBranchList(
                      widget.repoInfo, widget.selectedOrganization, provider),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: wCommitList(
                      widget.repoInfo, widget.selectedOrganization, provider),
                ),
              ]);
        }));
    ;
  }

  AppBar wAppBarView() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      leading: Builder(builder: (context) {
        return IconButton(
            color: Colors.transparent,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left, color: Colors.white));
      }),
      title: const Text("Projects",
          style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500)),
      centerTitle: true,
    );
  }

  wCardView(Repository repoInfo, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFF5F5FD)),
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: [
            const BoxShadow(
              color: Color(0xFFF9F9FF),
              blurRadius: 12,
              offset: Offset(0, 3),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFFF5F5FD)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Image.network(repoInfo.owner.avatarUrl)),
                const SizedBox(width: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      repoInfo.name,
                      style: const TextStyle(
                          color: Color(0xFF27274A),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      repoInfo.owner.login,
                      style: const TextStyle(
                          color: Color(0xFF5F607E),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              ],
            ),
            Container(
              width: 24,
              height: 24,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: const Icon(FluentIcons.chevron_right_48_regular),
            ),
          ],
        ),
      ),
    );
  }

  wRepoInfo(Repository repoInfo, OrganizationModel? selectedOrganization) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      color: kPrimaryColor,
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                    width: 45,
                    height: 45,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFFD3DDFF)),
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network('${repoInfo.owner.avatarUrl}',
                          fit: BoxFit.cover),
                    )),
                const SizedBox(width: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      repoInfo.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      repoInfo.fullName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Last Update - ${repoInfo.updatedAt}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )),
    );
  }

  wBranchList(Repository repoInfo, OrganizationModel? selectedOrganization,
      RepoInfoProvider provider) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...List.generate(provider.branchList.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    tapIndex = index;
                  });
                  provider.getFirstBranchesCommit(provider.branchList[index],
                      widget.selectedOrganization!, widget.repoInfo);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:5.0),
                  child: Container(
                    
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                    decoration: tapIndex == index
                        ? ShapeDecoration(
                            color: const Color(0xFF27274A),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFF27274A)),
                              borderRadius: BorderRadius.circular(43),
                            ),
                          )
                        : ShapeDecoration(
                            color: const Color(0xFFF3F3FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(66),
                            ),
                          ),
                    child: Center(
                      child: Text(
                        '${provider.branchList[index].name}',
                        style: tapIndex == index
                            ? TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              )
                            : TextStyle(
                                color: Color(0xFF5F607E),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500
                              ),
                      ),
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  wCommitList(Repository repoInfo, OrganizationModel? selectedOrganization,
      RepoInfoProvider provider) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(provider.commitInfo.length, (index) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      // padding: const EdgeInsets.all(10),
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFFF5EA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/folder.svg')
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          provider
                                              .commitInfo[index].commit.message,
                                          style: TextStyle(
                                            color: Color(0xFF27274A),
                                            fontSize: 16,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Container(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${provider.commitInfo[index].commit.committer.date}',
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF5F607E),
                                                        fontSize: 14,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 11.67,
                                          height: 14,
                                          child: SvgPicture.asset(
                                              'assets/images/profileuser.svg'),
                                        ),
                                        const SizedBox(width: 7),
                                        Text(
                                          '${provider.commitInfo[index].commit.committer.name}',
                                          style: TextStyle(
                                            color: Color(0xFF5F607E),
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
