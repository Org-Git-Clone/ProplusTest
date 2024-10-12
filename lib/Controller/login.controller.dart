import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Utils/navigation.dart';
import '../utils/sharedPrefs.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> signInWithGithub(BuildContext context) async {
    try {
      _setLoading(true);
      UserCredential userCredential = await _signInWithGithub();

      // Store the user information in shared preferences
      SharedPrefs.setUserName(
          userCredential?.additionalUserInfo?.username ?? "");
      SharedPrefs.isLoggedin(1);

      if (context.mounted) {
        router.go('/dashboard');
      }
    } catch (e) {
      // Handle error (e.g., show alert)
      debugPrint('Error during sign-in: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<UserCredential> _signInWithGithub() async {
    GithubAuthProvider githubAuthProvider = GithubAuthProvider();
    return await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
