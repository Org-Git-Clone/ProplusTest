import 'package:demoproject/Utils/constants.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../Controller/repo.controller.dart';
import '../Model/repo.model.dart';
import '../Utils/sharedPrefs.dart';
import 'drawer.view.dart';

class RepoInfoView extends StatefulWidget {
  const RepoInfoView({super.key});

  @override
  State<RepoInfoView> createState() => _RepoInfoViewState();
}

class _RepoInfoViewState extends State<RepoInfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: wAppBarView(),
        drawer: NavigationDrawerView(),
        body: Consumer<RepositoryProvider>(builder: (context, provider, child) {
          return SingleChildScrollView(
              child: provider.selectedOrganization == null
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                          child: Text("No Organization Found",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500))),
                    )
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      wCompanyCard(provider),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Projects",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500)),
                      ),
                      wProjectList(provider)
                    ]));
        }));
  }

  wCompanyCard(RepositoryProvider provider) {
    show_log_error(
        "SharedPrefs.pref.getString('username') is ${SharedPrefs.pref.getString('username')}");
    return Stack(children: [
      Container(height: 70, color: kPrimaryColor),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                    'Hi ${SharedPrefs.pref.getString('username') ?? ''}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500))),
            Container(
                height: 90,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  shadows: [
                    const BoxShadow(
                      color: Color(0x1927274A),
                      blurRadius: 12,
                      offset: Offset(0, 3),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(children: [
                  const SizedBox(width: 10),
                  Container(
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFFEDECFF)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Image.network(
                        provider.selectedOrganization?.avatarUrl ?? ""),
                  ),
                  const SizedBox(width: 10),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${provider.selectedOrganization?.login}',
                            style: TextStyle(
                                color: Color(0xFF27274A),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500)),
                        Container(
                          width: 53,
                          height: 25,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF22CCCC),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                          ),
                          child: const Center(
                            child: Text(
                              'VGTS ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0.10,
                                letterSpacing: 0.12,
                              ),
                            ),
                          ),
                        )
                      ])
                ]))
          ],
        ),
      )
    ]);
  }

  AppBar wAppBarView() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      leading: Builder(builder: (context) {
        return IconButton(
            color: Colors.transparent,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu, color: Colors.white));
      }),
      title: const Text('Github',
          style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500)),
      actions: [
        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/images/notifiaction icon.svg'))
      ],
    );
  }

  wProjectList(RepositoryProvider provider) {
    return Column(children: [
      ...List.generate((provider.repoInfos).length, (index) {
        Repository repoInfo = provider.repoInfos[index];
        return wCardView(repoInfo, index);
      }),
    ]);
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
                SizedBox(width: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      repoInfo.name,
                      style: TextStyle(
                          color: Color(0xFF27274A),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      repoInfo.owner.login,
                      style: TextStyle(
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
              decoration: BoxDecoration(),
              child: Icon(FluentIcons.chevron_right_48_regular),
            ),
          ],
        ),
      ),
    );
  }
}
