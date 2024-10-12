import 'dart:convert';

import 'package:demoproject/Controller/org.controller.dart';
import 'package:demoproject/Controller/repo.controller.dart';
import 'package:demoproject/Utils/navigation.dart';
import 'package:demoproject/Utils/sharedPrefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Image.asset("assets/images/github-logo-vector 1.png"),
                  Image.asset("assets/images/loginbg.png"),
                  const Column(
                    children: [
                      Text('Lets built from here ...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                          width: 327,
                          child: Text(
                              'Our platform drives innovation with tools that boost developer velocity',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF5F607E),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400))),
                    ],
                  ),
                  SignInBtn(context)
                ])));
  }

  GestureDetector SignInBtn(BuildContext context) {
    return GestureDetector(
      onTap: handleSignIn,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: ShapeDecoration(
                color: kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13))),
            child: const Center(
                child: const Text(
              'Sign in with Github',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500),
            ))),
      ),
    );
  }

  Future<void> handleSignIn() async {
    try {
      showLoadingDialog(context);
      // router.go('/dashboard');
      UserCredential userCredential = await signInWithGithub();
      show_log_error(
          "userCredential is profile ${userCredential.additionalUserInfo?.profile}");
      SharedPrefs.pref.setString('profile',
          jsonEncode(userCredential.additionalUserInfo?.profile) ?? "");
      show_log_error(
          "userCredential is username ${userCredential.additionalUserInfo?.username}");
      SharedPrefs.pref.setString(
          'username', userCredential.additionalUserInfo?.username ?? "");
      show_log_error(
          "userCredential is providerId ${userCredential.additionalUserInfo?.providerId}");
      SharedPrefs.pref.setString(
          'providerId', userCredential.additionalUserInfo?.providerId ?? "");
      show_log_error(
          "userCredential is authorizationCode ${userCredential.additionalUserInfo?.authorizationCode}");
      SharedPrefs.pref.setString('authorizationCode',
          userCredential.additionalUserInfo?.authorizationCode ?? "");
      show_log_error(
          "userCredential is accessToken ${userCredential.credential?.accessToken}");
      SharedPrefs.pref.setString(
          'accessToken', userCredential.credential?.accessToken ?? "");
      show_log_error(
          "userCredential is token ${userCredential.credential?.token}");
      SharedPrefs.pref.setString(
          'token', userCredential.credential?.token.toString() ?? "");
      show_log_error(
          "userCredential is signInMethod ${userCredential.credential?.signInMethod}");
      SharedPrefs.pref.setString(
          'signInMethod', userCredential.credential?.signInMethod ?? "");
      show_log_error(
          "userCredential is asMap ${userCredential.credential?.asMap()}");
      SharedPrefs.pref
          .setString('asMap', jsonEncode(userCredential.credential?.asMap()));
      show_log_error(
          "userCredential is username ${userCredential.additionalUserInfo?.username}");
      SharedPrefs.pref.setString(
          'username', userCredential.additionalUserInfo?.username ?? "");
      SharedPrefs.setUserName(
          userCredential.additionalUserInfo?.username ?? "");
      if (context.mounted) {
        // Fetch organizations only once during initialization
        var orgList = Provider.of<OrganizationProvider>(context, listen: false);
        await orgList.fetchOrganizations();
        if (orgList.organizations.length > 0) {
          Provider.of<RepositoryProvider>(context, listen: false)
              .fetchRepoForOrg(orgList.organizations.first);
        }
        router.pop();
        SharedPrefs.isLoggedin(1);

        router.go('/dashboard');
      }
    } catch (e) {
      // callCustomStatusAlert(context, e.toString(), false);
    }
  }

  Future<UserCredential> signInWithGithub() async {
    GithubAuthProvider githubAuthProvider = GithubAuthProvider();
    return await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);
  }
}
